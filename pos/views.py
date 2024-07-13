from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from inventory.models import Inventory
from products.models import Item
from .models import Sale, SaleItem
from django.db.models import Sum
from django.utils.dateparse import parse_date
from django.template.loader import get_template
from django.conf import settings
from io import BytesIO
import xhtml2pdf.pisa as pisa
from django.core.mail import EmailMessage
import json

def poshome(request):
    inventory_items = Inventory.objects.select_related('item').values(
        'id', 'item__name', 'item__price', 'quantity', 'item__image'
    )
    items = list(inventory_items)
    return JsonResponse({'inventory_items': items})

@csrf_exempt
@require_http_methods(["POST"])
def completesale(request):
    try:
        data = json.loads(request.body)
        cart_items = data.get('cartItems', [])
        payment_method = data.get('paymentMethod')
        total_amount = data.get('totalAmount')

        if not payment_method or not total_amount:
            return JsonResponse({'message': 'Payment method and total amount are required'}, status=400)

        sale = Sale.objects.create(
            total_amount=total_amount,
            payment_method=payment_method,
            customer_name=data.get('customerName', ''),
            customer_contact=data.get('customerContact', '')
        )

        for item in cart_items:
            try:
                product = get_object_or_404(Item, pk=item['id'])
                SaleItem.objects.create(
                    sale=sale,
                    item=product,
                    quantity=item['quantity'],
                    price=item['price']
                )
                inventory_item = get_object_or_404(Inventory, item=product)
                inventory_item.quantity -= item['quantity']
                inventory_item.save()
            except Item.DoesNotExist:
                return JsonResponse({'message': f'Item with id {item["id"]} does not exist'}, status=400)
            except Inventory.DoesNotExist:
                return JsonResponse({'message': f'Inventory entry for item with id {item["id"]} does not exist'}, status=400)

        return JsonResponse({'message': 'Sale completed successfully'})
    
    except json.JSONDecodeError:
        return JsonResponse({'message': 'Invalid JSON'}, status=400)
    except Exception as e:
        return JsonResponse({'message': str(e)}, status=400)

    return JsonResponse({'message': 'Invalid request'}, status=400)

def pospage(request):
    return render(request, 'pos/pos.html')

def salesreport(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    sales = Sale.objects.all()
    if start_date and end_date:
        try:
            start_date = parse_date(start_date)
            end_date = parse_date(end_date)
            sales = sales.filter(created_at__date__gte=start_date, created_at__date__lte=end_date)
        except ValueError:
            pass  # Handle invalid date formats if necessary

    total_sales = sales.aggregate(total_amount=Sum('total_amount'))['total_amount'] or 0
    total_items_sold = SaleItem.objects.filter(sale__in=sales).aggregate(total_quantity=Sum('quantity'))['total_quantity'] or 0
    best_selling_items = SaleItem.objects.filter(sale__in=sales).values('item__name').annotate(total_quantity=Sum('quantity')).order_by('-total_quantity')[:5]

    context = {
        'total_sales': total_sales,
        'total_items_sold': total_items_sold,
        'best_selling_items': best_selling_items,
        'start_date': start_date,
        'end_date': end_date
    }

    return render(request, 'pos/salesreport.html', context)

def render_to_pdf(template_src, context_dict={}):
    template = get_template(template_src)
    html = template.render(context_dict)
    result = BytesIO()
    pisa_status = pisa.CreatePDF(BytesIO(html.encode("UTF-8")), dest=result)
    if pisa_status.err:
        return None
    return result.getvalue()

def salesreportpdf(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    sales = Sale.objects.all()
    if start_date and end_date:
        try:
            start_date = parse_date(start_date)
            end_date = parse_date(end_date)
            sales = sales.filter(created_at__date__gte=start_date, created_at__date__lte=end_date)
        except ValueError:
            pass  # Handle invalid date formats if necessary

    total_sales = sales.aggregate(total_amount=Sum('total_amount'))['total_amount'] or 0
    total_items_sold = SaleItem.objects.filter(sale__in=sales).aggregate(total_quantity=Sum('quantity'))['total_quantity'] or 0
    best_selling_items = SaleItem.objects.filter(sale__in=sales).values('item__name').annotate(total_quantity=Sum('quantity')).order_by('-total_quantity')[:5]

    context = {
        'total_sales': total_sales,
        'total_items_sold': total_items_sold,
        'best_selling_items': best_selling_items,
        'start_date': start_date,
        'end_date': end_date
    }

    pdf = render_to_pdf('pos/salesreportpdf.html', context)
    if pdf:
        response = HttpResponse(pdf, content_type='application/pdf')
        response['Content-Disposition'] = 'attachment; filename="sales_report.pdf"'
        return response
    return HttpResponse('We had some errors <pre>' + html + '</pre>')

def emailsalesreport(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    sales = Sale.objects.all()
    if start_date and end_date:
        try:
            start_date = parse_date(start_date)
            end_date = parse_date(end_date)
            sales = sales.filter(created_at__date__gte=start_date, created_at__date__lte=end_date)
        except ValueError:
            pass

    total_sales = sales.aggregate(total_amount=Sum('total_amount'))['total_amount'] or 0
    total_items_sold = SaleItem.objects.filter(sale__in=sales).aggregate(total_quantity=Sum('quantity'))['total_quantity'] or 0
    best_selling_items = SaleItem.objects.filter(sale__in=sales).values('item__name').annotate(total_quantity=Sum('quantity')).order_by('-total_quantity')[:5]

    context = {
        'total_sales': total_sales,
        'total_items_sold': total_items_sold,
        'best_selling_items': best_selling_items,
        'start_date': start_date,
        'end_date': end_date
    }

    pdf = render_to_pdf('pos/salesreportpdf.html', context)
    if pdf:
        email = EmailMessage(
            'Sales Report',
            'Please find the attached sales report.',
            settings.EMAIL_HOST_USER,
            ['emmanuelotieno2002@gmail.com']
        )
        email.attach('sales_report.pdf', pdf, 'application/pdf')
        email.send()
        return HttpResponse('Email sent successfully')
    return HttpResponse('Error generating PDF')

import html
from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from inventory.models import Inventory
from products.models import Item
from .models import Sale, SaleItem
from django.contrib.auth.decorators import login_required, permission_required
from django.db.models import Sum
from django.utils.dateparse import parse_date
from django.template.loader import get_template
from django.conf import settings
from io import BytesIO
import xhtml2pdf.pisa as pisa
from django.core.mail import EmailMessage
import json
import logging
from django.db import transaction


logger = logging.getLogger(__name__)

@login_required
def poshome(request):
    inventory_items = Inventory.objects.select_related('item').values(
        'id', 'item__name', 'item__price', 'quantity', 'item__image', 'item_id'
    )
    items = list(inventory_items)
    return JsonResponse({'inventory_items': items})


@login_required
@csrf_exempt
@permission_required('inventory.add_inventory', raise_exception=True)
def completesale(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            logger.debug(f"Received data: {data}")
            cart_items = data.get('cartItems', [])

            with transaction.atomic():
                sale = Sale.objects.create(
                    total_amount=data.get('totalAmount'),
                    payment_method=data.get('paymentMethod'),
                    customer_name=data.get('customerName', ''),
                    customer_contact=data.get('customerContact', '')
                )

                for item in cart_items:
                    item_id = item['id']
                    logger.debug(f"Processing cart item with ID: {item_id}")

                    # Verify if the item exists in the Item table
                    try:
                        product = get_object_or_404(Item, pk=item_id)
                        logger.debug(f"Found product: {product.name}")
                    except Exception as e:
                        logger.error(f"No Item matches the given query for ID: {item_id}")
                        return JsonResponse({'message': f'No Item matches the given query for ID: {item_id}'}, status=400)

                    SaleItem.objects.create(
                        sale=sale,
                        item=product,
                        quantity=item['quantity'],
                        price=item['price']
                    )

                    # Find the Inventory record based on the foreign key item_id
                    try:
                        inventory_item = get_object_or_404(Inventory, item_id=product.id)
                        logger.debug(f"Found inventory item with quantity: {inventory_item.quantity} (Item ID: {inventory_item.item_id})")
                    except Exception as e:
                        logger.error(f"No Inventory matches the given query for item ID: {product.id}")
                        return JsonResponse({'message': f'No Inventory matches the given query for item ID: {product.id}'}, status=400)

                    inventory_item.quantity -= item['quantity']
                    inventory_item.save()

            return JsonResponse({'message': 'Sale completed successfully'})

        except json.JSONDecodeError:
            logger.error("Invalid JSON")
            return JsonResponse({'message': 'Invalid JSON'}, status=400)
        except Exception as e:
            logger.error(f"Error completing sale: {e}")
            return JsonResponse({'message': str(e)}, status=400)

    return JsonResponse({'message': 'Invalid request'}, status=400)

@login_required
@permission_required('inventory.view_inventory', raise_exception=True)
def pospage(request):
    return render(request, 'pos/pos.html')

@login_required
@permission_required('sales.view_sale', raise_exception=True)
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

@login_required
@permission_required('sales.view_sale', raise_exception=True)
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

@login_required
@permission_required('sales.view_sale', raise_exception=True)
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

def render_to_pdf(template_src, context_dict={}):
    template = get_template(template_src)
    html = template.render(context_dict)
    result = BytesIO()
    pisa_status = pisa.CreatePDF(BytesIO(html.encode("UTF-8")), dest=result)
    if pisa_status.err:
        return None
    return result.getvalue()


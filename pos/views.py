from email.message import EmailMessage
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from inventory.models import Inventory
from products.models import Item
from .models import Sale, SaleItem
from django.db.models import Sum, Count
from django.utils.dateparse import parse_date
import xhtml2pdf.pisa as pisa
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
def completesale(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        customer_name = data.get('customer_name')
        customer_contact = data.get('customer_contact')
        payment_method = data.get('payment_method')
        items = data.get('items')

        sale = Sale.objects.create(
            customer_name=customer_name,
            customer_contact=customer_contact,
            payment_method=payment_method,
            total_amount=sum(item['price'] * item['quantity'] for item in items)
        )

        for item in items:
            product = Item.objects.get(pk=item['id'])
            sale_item = SaleItem.objects.create(
                sale=sale,
                item=product,
                quantity=item['quantity'],
                price=item['price']
            )
            inventory_item = Inventory.objects.get(item=product)
            inventory_item.quantity -= item['quantity']
            inventory_item.save()

        return JsonResponse({'success': True})

    return JsonResponse({'success': False}, status=400)

def pospage(request):
    return render(request, 'pos/pos.html')

def salesreport(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    sales = Sale.objects.all()
    if start_date and end_date:
        sales = sales.filter(created_at__date__gte=parse_date(start_date), created_at__date__lte=parse_date(end_date))

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
    result = HttpResponse(content_type='application/pdf')
    pisa_status = pisa.CreatePDF(html, dest=result)
    if pisa_status.err:
        return HttpResponse('We had some errors <pre>' + html + '</pre>')
    return result

def salesreportpdf(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    sales = Sale.objects.all()
    if start_date and end_date:
        sales = sales.filter(created_at__date__gte=parse_date(start_date), created_at__date__lte=parse_date(end_date))

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

    return render_to_pdf('pos/salesreportpdf.html', context)

def emailsalesreport(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    sales = Sale.objects.all()
    if start_date and end_date:
        sales = sales.filter(created_at__date__gte=parse_date(start_date), created_at__date__lte=parse_date(end_date))

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

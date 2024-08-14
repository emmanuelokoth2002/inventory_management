from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from inventory.models import Inventory
from products.models import Item
from .models import Sale, SaleItem
from django.contrib.auth.decorators import login_required, permission_required
from django.db.models import Sum
from django.utils.dateparse import parse_date
from django.conf import settings
from django.core.mail import EmailMessage
from io import BytesIO
import json
import logging
from django.db import transaction
from datetime import datetime
from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph, PageBreak, Image, Spacer
from reportlab.lib.units import inch

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
                    item_id = item.get('id')
                    product = get_object_or_404(Item, pk=item_id)
                    SaleItem.objects.create(
                        sale=sale,
                        item=product,
                        quantity=item.get('quantity'),
                        price=item.get('price')
                    )

                    inventory_item = get_object_or_404(Inventory, item_id=product.id)
                    inventory_item.quantity -= item.get('quantity')
                    inventory_item.save()

            # Generate the receipt PDF
            buffer = BytesIO()
            doc = SimpleDocTemplate(buffer, pagesize=letter)
            elements = []

            # Styles
            styles = getSampleStyleSheet()
            title_style = ParagraphStyle(name='TitleStyle', fontSize=18, alignment=1, spaceAfter=12, fontName="Helvetica-Bold")
            normal_style = ParagraphStyle(name='NormalStyle', fontSize=10, alignment=0)
            header_style = ParagraphStyle(name='HeaderStyle', fontSize=12, alignment=1, spaceAfter=6, fontName="Helvetica-Bold")
            bold_style = ParagraphStyle(name='BoldStyle', fontSize=10, fontName="Helvetica-Bold")
            note_style = ParagraphStyle(name='NoteStyle', fontSize=10, fontName="Helvetica")

            # Add Logo
            # Ensure you have a logo image and specify the correct path
            logo = Image("product_images\logo.jpg", 2*inch, 2*inch)
            elements.append(logo)

            # Title
            title = Paragraph("RECEIPT", title_style)
            elements.append(title)
            
            # Receipt Date
            today = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            date_paragraph = Paragraph(f"Receipt Date: {today}", normal_style)
            elements.append(date_paragraph)
            
            elements.append(Spacer(1, 12))

            # Company Info
            company_info = [
                ["Your Company Name"],
                ["123 Street Address, City, State Zip/Post Code"],
                ["Phone Number | Email Address"]
            ]
            company_table = Table(company_info)
            company_table.setStyle(TableStyle([
                ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
                ('FONTNAME', (0, 0), (-1, -1), 'Helvetica-Bold'),
                ('FONTSIZE', (0, 0), (-1, -1), 10),
                ('BOTTOMPADDING', (0, 0), (-1, -1), 12),
            ]))
            elements.append(company_table)

            elements.append(Spacer(1, 12))

            # Bill To / Ship To Information
            billing_info = [
                ['BILL TO', 'SHIP TO'],
                [data.get('customerName', 'N/A'), data.get('customerName', 'N/A')],
                [data.get('customerContact', 'N/A'), data.get('customerContact', 'N/A')]
            ]
            billing_table = Table(billing_info, colWidths=[3*inch, 3*inch])
            billing_table.setStyle(TableStyle([
                ('BACKGROUND', (0, 0), (-1, 0), colors.lightgrey),
                ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
                ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
                ('FONTSIZE', (0, 0), (-1, -1), 10),
                ('GRID', (0, 0), (-1, -1), 0.5, colors.grey),
            ]))
            elements.append(billing_table)

            elements.append(Spacer(1, 12))

            # Itemized Table
            item_data = [["DESCRIPTION", "QTY", "UNIT PRICE", "TOTAL"]]
            for item in cart_items:
                item_data.append([
                    item.get('name', 'N/A'),
                    item.get('quantity', 1),
                    f"Ksh{item.get('price', 0):.2f}",
                    f"Ksh{float(item.get('price')) * item.get('quantity'):.2f}"
                ])
            item_table = Table(item_data, colWidths=[3 * inch, 1 * inch, 1 * inch, 1 * inch])
            item_table.setStyle(TableStyle([
                ('BACKGROUND', (0, 0), (-1, 0), colors.lightgrey),
                ('GRID', (0, 0), (-1, -1), 0.5, colors.black),
                ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
                ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
                ('FONTNAME', (0, 1), (-1, -1), 'Helvetica'),
                ('FONTSIZE', (0, 0), (-1, -1), 10),
            ]))
            elements.append(item_table)

            elements.append(Spacer(1, 12))

            # Subtotals, Taxes, and Final Amount
            totals_data = [
                ['SUBTOTAL', f"Ksh{data.get('totalAmount', '0.00')}"],
                ['DISCOUNT', "Ksh0.00"],
                ['TAX RATE', "0.00%"],
                ['TOTAL TAX', "Ksh0.00"],
                ['SHIPPING/HANDLING', "Ksh0.00"],
                ['TOTAL', f"Ksh{data.get('totalAmount', '0.00')}"]
            ]
            totals_table = Table(totals_data, colWidths=[4 * inch, 2 * inch])
            totals_table.setStyle(TableStyle([
                ('ALIGN', (1, 0), (-1, -1), 'RIGHT'),
                ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
                ('FONTSIZE', (0, 0), (-1, -1), 10),
            ]))
            elements.append(totals_table)

            elements.append(Spacer(1, 24))

            # Remarks
            remarks = Paragraph("Produced by System Administrator...", note_style)
            elements.append(remarks)

            # Build PDF
            doc.build(elements)
            pdf = buffer.getvalue()
            buffer.close()

            response = HttpResponse(content_type='application/pdf')
            response['Content-Disposition'] = f'attachment; filename="receipt_{sale.id}.pdf"'
            response.write(pdf)
            return response

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

from reportlab.lib.pagesizes import A4, portrait

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

    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=portrait(A4), rightMargin=0.3 * inch, leftMargin=0.3 * inch, topMargin=0.3 * inch, bottomMargin=0.3 * inch)

    elements = []
    styles = getSampleStyleSheet()

    # Title
    title = Paragraph("Sales Report", styles['Title'])
    elements.append(title)

    # Sales Summary
    summary_data = [
        ['Total Sales', f"${total_sales}"],
        ['Total Items Sold', f"{total_items_sold}"]
    ]

    summary_table = Table(summary_data, colWidths=[2.5 * inch, 2 * inch])
    summary_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#f2f2f2")),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.black),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 4),  # Reduce padding
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 8),  # Reduce font size
    ]))
    elements.append(summary_table)

    # Centered Paragraph Style
    centered_style = ParagraphStyle(name="Centered", alignment=1, fontSize=14, spaceAfter=10)

    # Best Selling Items Header
    elements.append(Paragraph("Best Selling Items", centered_style))

    best_selling_data = [["Item Name", "Quantity Sold"]]
    best_selling_data.extend([[item['item__name'], item['total_quantity']] for item in best_selling_items])

    best_selling_table = Table(best_selling_data, colWidths=[2.5 * inch, 2 * inch])
    best_selling_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#e0e0e0")),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.black),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 4),  # Reduce padding
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 8),  # Reduce font size
        ('BACKGROUND', (0, 1), (-1, -1), colors.HexColor("#f2f2f2")),
    ]))
    elements.append(best_selling_table)

    # Inventory Report Header
    elements.append(Paragraph("Inventory Report", centered_style))

    inventory_items = Inventory.objects.select_related('item', 'warehouse').values(
        'item__name', 'warehouse__name', 'quantity', 'reorder_level'
    )

    inventory_data = [["Item Name", "Warehouse", "Stock Quantity", "Reorder Level"]]
    for item in inventory_items:
        inventory_data.append([
            item['item__name'],
            item['warehouse__name'],
            item['quantity'],
            item['reorder_level']
        ])

    inventory_table = Table(inventory_data, colWidths=[2 * inch, 2 * inch, 1 * inch, 1 * inch])
    inventory_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#d9d9d9")),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.black),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 4),  # Reduce padding
        ('FONTNAME', (0, 0), (-1, -1), 'Helvetica'),
        ('FONTSIZE', (0, 0), (-1, -1), 8),  # Reduce font size
        ('BACKGROUND', (0, 1), (-1, -1), colors.HexColor("#f7f7f7")),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
    ]))
    elements.append(inventory_table)

    doc.build(elements)
    buffer.seek(0)
    return HttpResponse(buffer, content_type='application/pdf')


@login_required
@permission_required('sales.view_sale', raise_exception=True)
def emailsalesreport(request):
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')

    pdf = salesreportpdf(request).getvalue()
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


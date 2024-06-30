from django.shortcuts import render
from django.db.models import Sum, Avg
from pos.models import Sale

def dashboard(request):
    total_sales = Sale.objects.aggregate(total_amount=Sum('total_amount'))['total_amount'] or 0
    total_transactions = Sale.objects.count()
    average_sale = Sale.objects.aggregate(avg_amount=Avg('total_amount'))['avg_amount'] or 0
    recent_transactions = Sale.objects.order_by('-created_at')[:5]

    # Calculate the total quantity for each sale
    for sale in recent_transactions:
        sale.total_qty = sale.items.aggregate(total_qty=Sum('quantity'))['total_qty'] or 0

    context = {
        'total_sales': total_sales,
        'total_transactions': total_transactions,
        'average_sale': average_sale,
        'recent_transactions': recent_transactions,
    }

    return render(request, 'core/dashboard.html', context)

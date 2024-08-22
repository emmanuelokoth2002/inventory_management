from django.shortcuts import render, redirect
from django.contrib.auth import login as auth_login, authenticate, logout
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db.models import Sum, Avg, F
from pos.models import Sale
from inventory.models import Inventory
from django.db.models.functions import ExtractWeekDay
from collections import defaultdict
from decimal import Decimal

@login_required
def dashboard_view(request):
    total_sales = Sale.objects.aggregate(total_amount=Sum('total_amount'))['total_amount'] or 0
    total_transactions = Sale.objects.count()
    average_sale = Sale.objects.aggregate(avg_amount=Avg('total_amount'))['avg_amount'] or 0
    recent_transactions = Sale.objects.order_by('-created_at')[:5]

    for sale in recent_transactions:
        sale.total_qty = sale.items.aggregate(total_qty=Sum('quantity'))['total_qty'] or 0

    low_stock_items = Inventory.objects.filter(quantity__lt=F('reorder_level'))

    # Get sales data grouped by day of the week
    sales_by_day = Sale.objects.annotate(day_of_week=ExtractWeekDay('created_at')).values('day_of_week').annotate(total_sales=Sum('total_amount')).order_by('day_of_week')

    # Initialize a list to hold sales amounts for each day of the week
    days_of_week = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    sales_data = defaultdict(lambda: 0)
    for sale in sales_by_day:
        sales_data[days_of_week[sale['day_of_week'] - 1]] = float(sale['total_sales']) if isinstance(sale['total_sales'], Decimal) else sale['total_sales']
    
    sales_chart_data = [sales_data[day] for day in days_of_week]

    # For the transactions chart, assuming you want to count the number of transactions per day
    transactions_by_day = Sale.objects.annotate(day_of_week=ExtractWeekDay('created_at')).values('day_of_week').annotate(total_transactions=Sum('id')).order_by('day_of_week')
    
    transactions_data = defaultdict(lambda: 0)
    for transaction in transactions_by_day:
        transactions_data[days_of_week[transaction['day_of_week'] - 1]] = int(transaction['total_transactions']) if isinstance(transaction['total_transactions'], Decimal) else transaction['total_transactions']

    transactions_chart_data = [transactions_data[day] for day in days_of_week]

    context = {
        'total_sales': total_sales,
        'total_transactions': total_transactions,
        'average_sale': average_sale,
        'recent_transactions': recent_transactions,
        'low_stock_items': low_stock_items,
        'sales_chart_data': sales_chart_data,
        'transactions_chart_data': transactions_chart_data,
    }

    return render(request, 'core/dashboard.html', context)

def logout_view(request):
    logout(request)
    return redirect('login')

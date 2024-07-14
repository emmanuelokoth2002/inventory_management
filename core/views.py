from django.shortcuts import render, redirect
from django.contrib.auth import login as auth_login, authenticate, logout
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.db.models import Sum, Avg
from pos.models import Sale

# @login_required
def dashboard_view(request):
    total_sales = Sale.objects.aggregate(total_amount=Sum('total_amount'))['total_amount'] or 0
    total_transactions = Sale.objects.count()
    average_sale = Sale.objects.aggregate(avg_amount=Avg('total_amount'))['avg_amount'] or 0
    recent_transactions = Sale.objects.order_by('-created_at')[:5]

    for sale in recent_transactions:
        sale.total_qty = sale.items.aggregate(total_qty=Sum('quantity'))['total_qty'] or 0

    context = {
        'total_sales': total_sales,
        'total_transactions': total_transactions,
        'average_sale': average_sale,
        'recent_transactions': recent_transactions,
    }

    return render(request, 'core/dashboard.html', context)

def logout_view(request):
    logout(request)
    return redirect('login')
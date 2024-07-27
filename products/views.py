from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse
from .models import Item, Category
from .forms import ItemForm, CategoryForm
from django.db.models import Q
from django.contrib.auth.decorators import login_required, permission_required

@login_required
def product(request):
    query = request.GET.get('q')
    category_filter = request.GET.get('category')
    sort_by = request.GET.get('sort')

    products = Item.objects.all()
    categories = Category.objects.all()

    if query:
        products = products.filter(
            Q(name__icontains=query) |
            Q(SKU__icontains=query) |
            Q(description__icontains=query)
        )

    if category_filter:
        products = products.filter(category__name__iexact=category_filter)

    if sort_by:
        products = products.order_by(sort_by)

    return render(request, 'products/products.html', {'products': products, 'categories': categories})

@login_required
@permission_required('your_app.add_item', raise_exception=True)
def addproduct(request):
    if request.method == 'POST':
        form = ItemForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect(reverse('product'))
    else:
        form = ItemForm()
    return render(request, 'products/productform.html', {'form': form})

@login_required
@permission_required('your_app.change_item', raise_exception=True)
def editproduct(request, pk):
    product = get_object_or_404(Item, pk=pk)
    if request.method == 'POST':
        form = ItemForm(request.POST, request.FILES, instance=product)
        if form.is_valid():
            form.save()
            return redirect(reverse('product'))
    else:
        form = ItemForm(instance=product)
    return render(request, 'products/productform.html', {'form': form})

@login_required
@permission_required('your_app.delete_item', raise_exception=True)
def deleteproduct(request, pk):
    product = get_object_or_404(Item, pk=pk)
    if request.method == 'POST':
        product.delete()
        return redirect(reverse('product'))
    return render(request, 'products/deleteproduct.html', {'product': product})

@login_required
@permission_required('your_app.add_category', raise_exception=True)
def addcategory(request):
    if request.method == 'POST':
        form = CategoryForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect(reverse('addproduct'))
    else:
        form = CategoryForm()
    return render(request, 'products/categoryform.html', {'form': form})
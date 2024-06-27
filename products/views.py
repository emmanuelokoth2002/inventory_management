from django.shortcuts import render, get_object_or_404, redirect
from django.urls import reverse
from .models import Item
from .forms import ItemForm

def product(request):
    products = Item.objects.all()
    return render(request, 'products/products.html', {'products': products})

def addproduct(request):
    if request.method == 'POST':
        form = ItemForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect(reverse('product'))
    else:
        form = ItemForm()
    return render(request, 'products/productform.html', {'form': form})

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

def deleteproduct(request, pk):
    product = get_object_or_404(Item, pk=pk)
    if request.method == 'POST':
        product.delete()
        return redirect(reverse('product'))
    return render(request, 'products/deleteproduct.html', {'product': product})
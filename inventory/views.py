from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required, permission_required
from .models import Inventory
from .forms import InventoryForm

@login_required
def inventory(request):
    inventories = Inventory.objects.all()
    return render(request, 'inventory/inventory.html', {'inventories': inventories})

@login_required
@permission_required('your_app.add_inventory', raise_exception=True)
def addinventory(request):
    if request.method == 'POST':
        form = InventoryForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('inventory')
    else:
        form = InventoryForm()
    return render(request, 'inventory/inventoryform.html', {'form': form})

@login_required
@permission_required('your_app.change_inventory', raise_exception=True)
def editinventory(request, pk):
    inventory = get_object_or_404(Inventory, pk=pk)
    if request.method == 'POST':
        form = InventoryForm(request.POST, instance=inventory)
        if form.is_valid():
            form.save()
            return redirect('inventory')
    else:
        form = InventoryForm(instance=inventory)
    return render(request, 'inventory/inventoryform.html', {'form': form})

@login_required
@permission_required('your_app.delete_inventory', raise_exception=True)
def deleteinventory(request, pk):
    inventory = get_object_or_404(Inventory, pk=pk)
    if request.method == 'POST':
        inventory.delete()
        return redirect('inventory')
    return render(request, 'inventory/deleteinventory.html', {'inventory': inventory})

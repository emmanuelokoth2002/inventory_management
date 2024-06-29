from django import forms
from .models import Inventory

class InventoryForm(forms.ModelForm):
    class Meta:
        model = Inventory
        fields = ['item', 'warehouse', 'quantity', 'reorder_level']

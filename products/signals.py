from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Item
from inventory.models import Inventory, Warehouse

@receiver(post_save, sender=Item)
def additemtoinventory(sender, instance, created, **kwargs):
    if created:
        warehouse, _ = Warehouse.objects.get_or_create(name='Default Warehouse', location='Default Location')
        Inventory.objects.create(item=instance, warehouse=warehouse, quantity=0, reorder_level=0)

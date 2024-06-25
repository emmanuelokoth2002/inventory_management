# inventory/admin.py
from django.contrib import admin
from .models import Inventory, Warehouse

admin.site.register(Inventory)
admin.site.register(Warehouse)


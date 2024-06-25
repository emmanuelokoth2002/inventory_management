from django.db import models
from core.models import BaseModel
from products.models import Item

class Warehouse(BaseModel):
    name = models.CharField(max_length=255)
    location = models.CharField(max_length=255)

    def __str__(self):
        return self.name

class Inventory(BaseModel):
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    reorder_level = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.item.name} in {self.warehouse.name}"


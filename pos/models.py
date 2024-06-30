from django.db import models
from core.models import BaseModel
from products.models import Item

class Sale(BaseModel):
    customer_name = models.CharField(max_length=255, blank=True, null=True)
    customer_contact = models.CharField(max_length=255, blank=True, null=True)
    payment_method = models.CharField(max_length=50, default='cash')
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"Sale {self.id} - {self.total_amount}"

class SaleItem(BaseModel):
    sale = models.ForeignKey(Sale, related_name='items', on_delete=models.CASCADE)
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"{self.quantity} x {self.item.name} for {self.sale}"

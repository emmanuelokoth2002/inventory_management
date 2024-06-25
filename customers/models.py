# customers/models.py
from django.db import models
from core.models import BaseModel

class Customer(BaseModel):
    name = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=15)
    address = models.TextField()

    def __str__(self):
        return self.name


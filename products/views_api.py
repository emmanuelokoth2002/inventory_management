from rest_framework import generics
from .models import Item
from .serializers import ItemSerializer

class ItemListAPIView(generics.ListAPIView):
    queryset = Item.objects.all()
    serializer_class = ItemSerializer
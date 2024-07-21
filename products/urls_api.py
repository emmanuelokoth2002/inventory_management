from django.urls import path
from .views_api import ItemListAPIView

urlpatterns = [
    path('items/', ItemListAPIView.as_view(), name='item-list'),
]
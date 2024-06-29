from django.urls import path
from . import views

urlpatterns = [
    path('', views.inventory, name='inventory'),
    path('add/', views.addinventory, name='addinventory'),
    path('edit/<int:pk>/', views.editinventory, name='editinventory'),
    path('delete/<int:pk>/', views.deleteinventory, name='deleteinventory'),
]

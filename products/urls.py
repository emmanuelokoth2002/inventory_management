from django.urls import path
from . import views

urlpatterns = [
    path('products/',views.product,name='product'),
    path('add/', views.addproduct, name='addproduct'),
    path('edit/<int:pk>/', views.editproduct, name='editproduct'),
    path('delete/<int:pk>/', views.deleteproduct, name='deleteproduct'),
]
from django.urls import path
from . import views

urlpatterns = [
    path('', views.pospage, name='pospage'),
    path('poshome/', views.poshome, name='poshome'),
    path('completesale/', views.completesale, name='completesale'),
    path('salesreport/', views.salesreport, name='salesreport'),
    path('salesreportpdf/', views.salesreportpdf, name='salesreportpdf'),
    path('emailsalesreport/', views.emailsalesreport, name='emailsalesreport'),
]

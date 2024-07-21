from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('users.urls')),
    path('dashboard/',include('core.urls')),
    path('products/',include('products.urls')),
    path('inventory/',include('inventory.urls')),
    path('pos/',include('pos.urls')),
    path('api/', include('products.urls_api')),
    path('custom_messages/', include('custom_messages.urls')),
]


if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
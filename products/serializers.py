from rest_framework import serializers
from .models import Item

class ItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = ['id', 'name', 'description', 'category', 'price', 'cost', 'SKU', 'barcode', 'image']
        
        def get_image_url(self, obj):
            request = self.context.get('request')
            if obj.image and hasattr(obj.image, 'url'):
                return request.build_absolute_uri(obj.image.url)
            return None
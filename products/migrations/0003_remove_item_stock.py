# Generated by Django 5.0.3 on 2024-07-04 19:46

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0002_item_image_item_stock'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='item',
            name='stock',
        ),
    ]
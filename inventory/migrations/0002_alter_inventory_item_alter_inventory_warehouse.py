# Generated by Django 5.0.3 on 2024-06-29 11:54

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('inventory', '0001_initial'),
        ('products', '0002_item_image_item_stock'),
    ]

    operations = [
        migrations.AlterField(
            model_name='inventory',
            name='item',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='inventory', to='products.item'),
        ),
        migrations.AlterField(
            model_name='inventory',
            name='warehouse',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='inventory', to='inventory.warehouse'),
        ),
    ]
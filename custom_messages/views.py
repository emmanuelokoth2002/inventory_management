from django.shortcuts import render

def custom_403_view(request, exception=None):
    return render(request, 'messages/403.html', status=403)

def custom_400_view(request, exception=None):
    return render(request, 'custom_messages/400.html', status=400)

def custom_404_view(request, exception=None):
    return render(request, 'custom_messages/404.html', status=404)

def custom_500_view(request):
    return render(request, 'custom_messages/500.html', status=500)
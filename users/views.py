from django.shortcuts import render, redirect
from django.contrib.auth.models import User, Permission
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required, permission_required
from .forms import UserRegisterForm, UserLoginForm

def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Account created successfully. You can now log in.')
            return redirect('login')
        else:
            messages.error(request, 'Please correct the errors below.')
    else:
        form = UserRegisterForm()
    return render(request, 'users/register.html', {'form': form})

def user_login(request):
    if request.method == 'POST':
        form = UserLoginForm(request, data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('dashboard')
        else:
            messages.error(request, 'Invalid username or password')
    else:
        form = UserLoginForm()

    return render(request, 'users/login.html', {'form': form})

@login_required
@permission_required('auth.change_user', raise_exception=True)
def assign_roles(request):
    users = User.objects.all()
    permissions = Permission.objects.all()

    if request.method == 'POST':
        user_id = request.POST.get('user')
        permission_ids = request.POST.getlist('permissions')

        try:
            user = User.objects.get(pk=user_id)
            user.user_permissions.set(permission_ids)
            messages.success(request, f'Permissions updated for {user.username}')
        except User.DoesNotExist:
            messages.error(request, 'User not found')
        except Exception as e:
            messages.error(request, 'An error occurred while updating permissions')

        return redirect('assign_roles')

    context = {
        'users': users,
        'permissions': permissions
    }
    return render(request, 'users/assign_roles.html', context)

def user_logout(request):
    logout(request)
    messages.success(request, 'You have been logged out successfully.')
    return redirect('login')

from django.shortcuts import redirect, render
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout as logout_, login as login_ , authenticate 
from django.contrib import messages
from django.contrib.auth.models import User

def loginView(request):
    current_user = User.objects.filter(id=request.user.id).first()
    if current_user is not None:
        return redirect('index')
    if request.method == 'POST':
        username = request.POST.get("username")
        password = request.POST.get("password")
        user = authenticate(username=username,password=password)
        if user is not None:
            login_(request,user)
            return redirect("index")
        messages.info(request,"Kullanıcı Adı Veya Şifre Hatalı")
        return render(request,"login.html")
    else:
        return render(request,"login.html")

def logoutView(request):
    logout_(request)
    return redirect("login")
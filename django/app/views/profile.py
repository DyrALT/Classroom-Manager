from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from ..models.Task import Task
from django.contrib import messages
from ..models.Student import Student
from ..models.Teacher import Teacher


@login_required(login_url='/login')
def profileView(request):
    if request.method == 'GET':
        return render(request,"profile.html")
    if request.method == 'POST':
        user = request.user
        
        firstName = request.POST.get('firstName')
        lastName = request.POST.get('lastName')
        password = request.POST.get('password')
        password_confirm = request.POST.get('password_confirm')

        if password != password_confirm :
            messages.info(request,'Sifreler eslesmiyor')
            return render(request,"profile.html")
        if password.strip() == '':
            messages.info(request,'Sifreniz bos olamaz')
            return render(request,"profile.html")
        if firstName.strip() == '' or lastName.strip() == '':
            messages.info(request,'Adiniz veya soyadiniz bos olamaz')
            return render(request,"profile.html")
        else:
            user.first_name,user.last_name = firstName,lastName
            user.username = f'{firstName} {lastName}'
            user.set_password(password)
            user.save()
            messages.success(request,'Ayarlariniz guncellendi')
            return render(request,"profile.html")
            

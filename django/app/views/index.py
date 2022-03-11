from django.shortcuts import redirect, render
from django.contrib.auth.decorators import login_required
from ..models.Task import Task
from ..models.Student import Student
from ..models.Teacher import Teacher
from django.contrib.auth import logout as logout_
from django.contrib import messages


@login_required(login_url='/login')
def indexView(request):
    try:
        student = request.user.student.get()
        context = {
        'finished' : student.finished.all(),
        'unfinished' : student.unfinished.all(),
        }
        return render(request,'index.html',context)

    except:
        try:
            teacher = request.user.teacher.first()
            context={
            'tasks' : teacher.tasks.all()
            }
            return render(request,'index.html',context)
        except :
            messages.info(request,'Kayitli Ogretmen Yada Ogrenci Bulunamadi')
            logout_(request)
            return redirect('login')
        



from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from ..models.Task import Task
from ..models.Student import Student
from ..models.Teacher import Teacher

@login_required(login_url='/login')
def indexView(request):
    try:
        student = request.user.student.get()
        context = {
        'finished' : student.finished.all(),
        'not_doing' : student.not_doing.all(),
        }
    except:
        context={}
    return render(request,'index.html',context)


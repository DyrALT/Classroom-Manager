from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from ..models.Task import Task
from ..models.Student import Student
from ..models.Teacher import Teacher

@login_required(login_url='/login')
def index(request):
    try:
        student = request.user.student.get()
        context = {
        'finished' : student.finished_tasks.all(),
        'doing' : student.doing_tasks.all(),
        'not_doing' : student.not_doing_tasks.all(),
        }
    except:
        context={}
    print(f'context=====> f{context}')
    return render(request,'index.html',context)
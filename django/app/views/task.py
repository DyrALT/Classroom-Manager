from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from ..models.Task import Task
from ..models.Student import Student
from ..models.Teacher import Teacher

@login_required(login_url='/login')
def taskView(request,id):
    task = Task.objects.get(id=id)
    context = {
        'task' : task
    }
    return render(request,'task.html',context)


@login_required(login_url='/login')
def finishTaskView(request,id):
    task = Task.objects.get(id=id)
    student = request.user.student.get()
    print(f'''
    task = {task}
    student = {student}
    ''')
    
    return redirect('index')
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from ..models.Task import Task
from ..models.Student import Student
from ..models.Teacher import Teacher


@login_required(login_url='/login')
def taskView(request, id):
    try:
        task = Task.objects.get(id=id)
        student = request.user.student.get()
        if student not in task.finished.all() and student not in task.unfinished.all():
            return redirect('index')
        context = {
            'task': task
        }
        return render(request, 'task.html', context)
    except:
        task = Task.objects.get(id=id)
        teacher = request.user.teacher.first()
        if task not in teacher.tasks.all():
            return redirect('index')
        context = {
            'task': task
        }
        return render(request, 'task.html', context)



@login_required(login_url='/login')
def finishTaskView(request, id):
    try:
        task = Task.objects.get(id=id)
        student = request.user.student.get()
    except:
        return redirect('index')
    if student in task.finished.all():
        messages.info(request, 'Bu Gorevi Zaten Tamamlamissiniz')
        return redirect('index')
    else:
        if student not in task.unfinished.all():
            return redirect('index')
        messages.success(request, 'Gorevi tamamladiniz')
        task.unfinished.remove(student)
        task.finished.add(student)
        return redirect('index')


@login_required(login_url='/login')
def unFinishedTaskView(request, id):
    try:
        task = Task.objects.get(id=id)
        student = request.user.student.get()
    except:
        return redirect('index')
    if student in task.unfinished.all():
        messages.info(request, 'Bu Gorevi Zaten Tamamlamamissiniz')
        return redirect('index')
    else:
        if student not in task.finished.all():
            return redirect('index')
        messages.success(request, 'Gorevi tamamlamadiniz')
        task.finished.remove(student)
        task.unfinished.add(student)
        return redirect('index')

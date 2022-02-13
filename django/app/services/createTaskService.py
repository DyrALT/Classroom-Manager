from django.contrib.auth.models import User
from ..models.Task import Task

def createTaskService(request):
    data = request.data
    try:
        task = Task(title=data['title'],content=data['content'],teacher_id=data['teacher_id'])
    except KeyError:
        return None
    task.save()
    if task is not None:
        return task
    else:
        return None
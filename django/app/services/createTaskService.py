from django.contrib.auth.models import User
from ..models.Task import Task

def createTaskService(request):
    data = request.data
    teacher = request.user.teacher.first()
    try:
        task = Task(
            title=data['title'],
            content=data['content'],
            teacher_id=request.user.teacher.first().id            )
    except KeyError:
        return None
    task.save()

    task.unfinished.add(*list(teacher.students.all().values_list('id',flat=True)))
    if task is not None:
        return task
    else:
        return None
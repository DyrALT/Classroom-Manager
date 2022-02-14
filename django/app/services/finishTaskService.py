from ..models.Task import Task

def finishTaskService(request):
    data = request.data
    try:
        task = Task.objects.get(id=data['task_id'])
        task.delete()
        return True
    except:
        return False
    
    
    
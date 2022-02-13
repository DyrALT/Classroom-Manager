from django.contrib.auth.models import User
from ..models.Teacher import Teacher

def createTeacherService(request):
    data = request.data
    try:
        user = User(username=f'{data["firstName"]} {data["lastName"]}',first_name=data["firstName"],last_name=data["lastName"],password=data["password"],email=data['email'])
    except KeyError:
        return None
    user.save()
    teacher = Teacher(user=user)
    teacher.save()
    if teacher is not None:
        return teacher
    else:
        return None
        
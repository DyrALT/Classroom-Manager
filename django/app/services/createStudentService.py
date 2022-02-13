from django.contrib.auth.models import User
from ..models.Student import Student

def createStudentService(request):
    data = request.data
    try:
        user = User(username=f'{data["firstName"]} {data["lastName"]}',first_name=data["firstName"],last_name=data["lastName"],password=data["password"])
        teacher_id = data['teacher_id']
    except KeyError:
        return None
    user.save()
    student = Student(user=user,teacher_id=teacher_id)
    student.save()
    if student is not None:
        return student
    else:
        return None
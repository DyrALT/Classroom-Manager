from django.contrib.auth.models import User
from ..models.Student import Student

def deleteStudentService(request):
    data = request.data
    try:
        teacher = request.user.teacher.first()
        student = Student.objects.get(id=data['student_id'])
        student_user = User.objects.get(id=student.user.id)
        student.delete()
        student_user.delete()
        return True
    except:
        return False
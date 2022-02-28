
from ..models.Student import Student


def updateStudentService(request):
    data = request.data
    try:
        student = Student.objects.get(id=data['student_id'])
        if data['password'].replace(" ", "") is not '':
            student.user.set_password(data['password'])
            student.user.save()
       
        student.user.first_name = data['firstName']
        student.user.last_name = data['lastName']
        student.user.username = f'{data["firstName"]} {data["lastName"]}'
        student.user.save()
        return True
    except :
        False 
    
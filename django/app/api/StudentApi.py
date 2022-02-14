from rest_framework.views import APIView
from rest_framework.response import Response
from ..Texts import Text
from ..serializers.studentSerializer import StudentSerializer
from ..models.Teacher import Teacher
from ..models.Student import Student
from ..services.createStudentService import createStudentService
from rest_framework import status

class CreateStudent(APIView):
    def post(self, request):
        data = createStudentService(request)
        if data is not None:
            serializer = StudentSerializer(data)
            return Response(data={
                'status':'ok',
                'data': serializer.data,
                'description':None
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST,data={
                'status':'error',
                'data': None,
                'description': Text.key_error.value
            })
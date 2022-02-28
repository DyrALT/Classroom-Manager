from rest_framework.views import APIView
from rest_framework.response import Response

from ..services.updateStudentService import updateStudentService
from ..Texts import Text
from ..serializers.studentSerializer import StudentSerializer
from ..models.Teacher import Teacher
from ..models.Student import Student
from ..services.createStudentService import createStudentService
from rest_framework import status
from rest_framework.permissions import IsAuthenticated

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

class ListStudentView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request):
        try:
            query = request.user.teacher.first().students.all()
        except :
            return Response(status=status.HTTP_401_UNAUTHORIZED,data={
                'status':'error',
                'data': None,
                'description': None
            })
        serializer = StudentSerializer(query,many=True)
        return Response(status=status.HTTP_200_OK,data=serializer.data)
        

class UpdateStudentView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = updateStudentService(request)
        if data:
            return Response(status=status.HTTP_200_OK,data={
                'data': None,
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST,data={
                'data': None,
            })
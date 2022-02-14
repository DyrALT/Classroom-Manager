from rest_framework.views import APIView
from rest_framework.response import Response
from ..Texts import Text
from ..serializers.teacherSerializer import StudentSerializer
from ..models.Teacher import Teacher
from ..services.createTeacherService import createTeacherService
from rest_framework import status


class CreateTeacher(APIView):
    def post(self,request):
        data = createTeacherService(request)
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


class ListTeacher(APIView):
    def get(self,request):
        query = Teacher.objects.all()
        serializer = StudentSerializer(query,many=True)
        return Response(data=serializer.data)
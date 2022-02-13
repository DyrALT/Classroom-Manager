from rest_framework.views import APIView
from rest_framework.response import Response
from ..serializers.taskSerializer import TaskSerializer
from ..services.createTaskService import createTaskService
from ..Texts import ErrorText
from rest_framework import status
from ..models.Teacher import Teacher
from ..models.Student import Student

class CreateTask(APIView):
    def post(self, request):
        data = createTaskService(request)
        if data is not None:
            serializer = TaskSerializer(data)
            return Response(data={
                'status':'ok',
                'data': serializer.data,
                'description':None
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST,data={
                'status':'error',
                'data': None,
                'description': ErrorText.key_error.value
            })
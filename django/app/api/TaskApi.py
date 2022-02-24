from rest_framework.views import APIView
from rest_framework.response import Response
from ..serializers.taskSerializer import TaskSerializer
from ..services.createTaskService import createTaskService
from ..services.finishTaskService import finishTaskService
from ..Texts import Text
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from ..models.Teacher import Teacher
from ..models.Student import Student


class CreateTask(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        if request.user.teacher.first() is None:
            return Response(status=status.HTTP_401_UNAUTHORIZED, data={
                'status': 'error',
                'data': None,
                'description': None
            })
        data = createTaskService(request)
        if data is not None:
            serializer = TaskSerializer(data)
            return Response(data={
                'status': 'ok',
                'data': serializer.data,
                'description': None
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={
                'status': 'error',
                'data': None,
                'description': Text.key_error.value
            })


class ListTasks(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        query = request.user.teacher.first().tasks.all()
        if query is not None:
            serializer = TaskSerializer(query, many=True)
            return Response(data={
                'tasks':serializer.data
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={
                'status': 'error',
                'data': None,
                'description': Text.no_tasks.value
            })


class FinishTask(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = finishTaskService(request)
        if data:
            return Response(data={
                'status': 'ok',
                'data': None,
                'description': Text.delete_task_success.value
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={
                'status': 'error',
                'data': None,
                'description': Text.delete_task_error.value
            })

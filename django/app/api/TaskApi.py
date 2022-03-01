from re import M
from rest_framework.views import APIView
from rest_framework.response import Response

from ..models.Task import Task
from ..serializers.taskSerializer import TaskSerializer
from ..services.createTaskService import createTaskService
from ..services.finishTaskService import finishTaskService
from ..Texts import Text
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from ..models.Teacher import Teacher
from ..models.Student import Student


class CreateTaskView(APIView):
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


class ListTasksView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            query = request.user.teacher.first().tasks.all()
        except:
            return Response(status=status.HTTP_403_FORBIDDEN, data={
                'status': 'error',
                'data': None,
                'description': None
            })
        if query is not None:
            serializer = TaskSerializer(query, many=True)
            return Response(data={
                'tasks': serializer.data
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={
                'status': 'error',
                'data': None,
                'description': Text.no_tasks.value
            })


class FinishTaskView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        data = finishTaskService(request)
        if data:
            return Response(data={
                'data': None,
            })
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={
                'status': 'error',
                'data': None,
                'description': Text.delete_task_error.value
            })


class DetailTaskView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        query = Task.objects.filter(id=request.data['id'])
        serializer = TaskSerializer(query,many=True)
        
        if serializer is not None:
            return Response(data=

                serializer.data[0],

            )
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={
                'status': 'error',
                'data': None,
                'description': Text.key_error.value
            })

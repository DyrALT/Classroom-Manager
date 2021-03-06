from rest_framework import serializers
from ..models.Task import Task
from .studentSerializer import StudentSerializer


class TaskSerializer(serializers.ModelSerializer):
    finished = StudentSerializer(many=True)
    unfinished = StudentSerializer(many=True)
    created_date = serializers.DateTimeField(format='%d/%m/%y %H:%M')

    class Meta:
        model = Task
        fields = ['id', 'title', 'content',
                  'created_date', 'finished', 'unfinished']

from rest_framework import serializers
from ..models.Student import Student

class StudentSerializer(serializers.ModelSerializer):
    username = serializers.CharField(max_length=35,source='user.username')
    class Meta:
        model = Student
        fields = ['id','username']
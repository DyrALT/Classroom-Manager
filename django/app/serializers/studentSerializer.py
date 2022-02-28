from rest_framework import serializers
from ..models.Student import Student

class StudentSerializer(serializers.ModelSerializer):
    username = serializers.CharField(max_length=35,source='user.username')
    first_name = serializers.CharField(max_length=35,source='user.first_name')
    last_name = serializers.CharField(max_length=35,source='user.last_name')
    class Meta:
        model = Student
        fields = ['id','username','first_name','last_name']
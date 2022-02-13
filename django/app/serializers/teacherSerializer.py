from rest_framework import serializers
from ..models.Teacher import Teacher

class TeacherSerializer(serializers.ModelSerializer):
    username = serializers.CharField(max_length=35,source='user.username')
    class Meta:
        model = Teacher
        fields = ['id','username']
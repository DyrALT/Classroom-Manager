from django.db import models
from .Teacher import Teacher

class Student(models.Model):
    user = models.ForeignKey('auth.User',related_name='student',on_delete=models.CASCADE)
    teacher = models.ForeignKey(Teacher,on_delete=models.CASCADE,related_name='students')

    def __str__(self):
        return self.user.username
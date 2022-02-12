from django.db import models
from .Teacher import Teacher

class Student(models.Model):
    name = models.CharField(max_length=25,)
    teacher = models.ForeignKey(Teacher,on_delete=models.CASCADE,related_name='student')

    def __str__(self):
        return self.name
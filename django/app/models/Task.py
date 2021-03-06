from django.db import models

from .Student import Student
from .Teacher import Teacher

class Task(models.Model):
    title = models.CharField(max_length=60)
    content = models.TextField(max_length=400)
    teacher = models.ForeignKey(Teacher,on_delete=models.CASCADE,related_name='tasks')
    finished = models.ManyToManyField(Student,blank=True,related_name="finished")
    unfinished = models.ManyToManyField(Student,blank=True,related_name="unfinished")
    created_date = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return self.title
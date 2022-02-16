from django.db import models

from .Student import Student
from .Teacher import Teacher

class Task(models.Model):
    title = models.CharField(max_length=60)
    content = models.TextField(max_length=255)
    teacher = models.ForeignKey(Teacher,on_delete=models.CASCADE,related_name='tasks')
    status = models.BooleanField(default=True)
    finished = models.ManyToManyField(Student,blank=True,related_name="finished_tasks")
    doing = models.ManyToManyField(Student,blank=True,related_name="doing_tasks")
    not_doing = models.ManyToManyField(Student,blank=True,related_name="not_doing_tasks")

    def __str__(self):
        return self.title
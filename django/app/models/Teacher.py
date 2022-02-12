from django.db import models


class Teacher(models.Model):
    user = models.ForeignKey('auth.User',on_delete=models.CASCADE,related_name='teacher')
    
    def __str__(self):
        return self.user.username
from django.contrib import admin

from .models.Task import Task
from .models.Teacher import Teacher
from .models.Student import Student
# Register your models here.
class TaskAdmin(admin.ModelAdmin):
    filter_horizontal = ('finished','doing','not_doing')
admin.site.register(Teacher)
admin.site.register(Student)
admin.site.register(Task,TaskAdmin)
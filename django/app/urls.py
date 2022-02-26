from django.contrib import admin
from django.urls import path,include
from rest_framework_simplejwt.views import TokenRefreshView,TokenVerifyView
from .api.TeacherApi import ListTeacher,CreateTeacher
from .api.StudentApi import CreateStudent, ListStudentView
from .api.TaskApi import CreateTask, FinishTask,ListTasks
from .utils.CustomToken import MyTokenObtainPairView
from .views.index import indexView
from .views.login import loginView,logoutView
from .views.task import taskView,finishTaskView,unFinishedTaskView
from .views.profile import profileView
urlpatterns = [
    path('',indexView,name='index'),
    path('login/',loginView,name='login'),
    path('logout/',logoutView),
    path('task/<str:id>',taskView),
    path('task/finish/<str:id>',finishTaskView),
    path('task/unfinish/<str:id>',unFinishedTaskView),
    path('profile/',profileView),
    #api
    path('api/create/teacher/',CreateTeacher.as_view()),
    path('api/create/student/',CreateStudent.as_view()),
    path('api/create/task/',CreateTask.as_view()),
    path('api/list/task/',ListTasks.as_view()),
    path('api/list/student/',ListStudentView.as_view()),
    path('api/delete/task/',FinishTask.as_view()),
    path('api/token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
]

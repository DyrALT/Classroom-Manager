from django.contrib import admin
from django.urls import path,include
from rest_framework_simplejwt.views import TokenRefreshView,TokenVerifyView
from .api.TeacherApi import ListTeacher,CreateTeacherView
from .api.StudentApi import CreateStudentView, DeleteStudentView, ListStudentView,UpdateStudentView
from .api.TaskApi import CreateTaskView, DetailTaskView, FinishTaskView,ListTasksView
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
    path('api/update/student/',UpdateStudentView.as_view()),
    path('api/create/teacher/',CreateTeacherView.as_view()),
    path('api/create/student/',CreateStudentView.as_view()),
    path('api/create/task/',CreateTaskView.as_view()),
    path('api/list/task/',ListTasksView.as_view()),
    path('api/list/student/',ListStudentView.as_view()),
    path('api/delete/task/',FinishTaskView.as_view()),
    path('api/token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
    path('api/detail/task/', DetailTaskView.as_view()),
    path('api/delete/student/', DeleteStudentView.as_view()),
]

from django.contrib import admin
from django.urls import path,include
from rest_framework_simplejwt.views import TokenRefreshView,TokenVerifyView
from .api.TeacherApi import ListTeacher,CreateTeacher
from .utils.CustomToken import MyTokenObtainPairView

urlpatterns = [
    path('api/create/teacher/',CreateTeacher.as_view()),
    path('api/token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
]

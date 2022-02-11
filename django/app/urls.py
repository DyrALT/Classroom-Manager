from django.contrib import admin
from django.urls import path,include
from rest_framework_simplejwt.views import TokenRefreshView,TokenVerifyView
from .utils.CustomToken import MyTokenObtainPairView
from .views.views import *
urlpatterns = [
    path('',IndexView.as_view()),
    path('api/token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
]

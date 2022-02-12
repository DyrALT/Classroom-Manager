from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import authentication, permissions
# Create your views here.

class IndexView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    def get(self, request):
        return Response(data={'status':'ok','data': 'selam','description':None})
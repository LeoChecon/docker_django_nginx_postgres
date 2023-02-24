from django.urls import path

from .views import create_post, hello_world

urlpatterns = [
    path('', hello_world, name='HelloWorld'),
    path('create', create_post, name='CreatePost'),
]

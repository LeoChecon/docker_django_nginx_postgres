from django.http import HttpResponse
from django.shortcuts import render

from .models import Postagens


def hello_world(request):
    post_list = Postagens.objects.all()
    return render(request, 'hello_world.html', context={
        "post_list": post_list
    })

def create_post(request):
    Postagens.objects.create()
    return hello_world(request)
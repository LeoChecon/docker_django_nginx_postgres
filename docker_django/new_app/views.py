from django.http import HttpResponse
from django.shortcuts import render

from .models import Visits


def hello_world(request):
    Visits.objects.create()
    visit_list = Visits.objects.all()
    return render(request, 'hello_world.html', context={
        "visit_list": visit_list
    })
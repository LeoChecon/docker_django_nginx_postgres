from django.db import models

# Create your models here.

class Visits(models.Model):
    time_stamp = models.DateTimeField(auto_now_add=True)

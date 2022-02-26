from django.contrib.auth import views
from django.urls import path
from .views import *


app_name = 'account'
urlpatterns = [
    path('', home, name='home'),
    path('profile/', Profile, name="profile"),
]

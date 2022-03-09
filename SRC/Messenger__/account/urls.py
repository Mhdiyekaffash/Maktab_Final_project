from django.urls import path
from .views import *


app_name = 'account'
urlpatterns = [
    path('', home, name='home'),
    path('', home, name='home'),
    path('logout/', logout_view, name='logout'),
]

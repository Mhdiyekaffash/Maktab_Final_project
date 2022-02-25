from django.urls import path
from .views import *


urlpatterns = [
    path('email-create/', EmailCreate.as_view(), name="email-create"),
]
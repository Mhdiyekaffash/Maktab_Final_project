from django.http import HttpResponse
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views.generic import CreateView
from .mixins import FieldsMixin, OwnerAccountAccessMixin, FormValidMixin
from .models import Email


class EmailCreate(OwnerAccountAccessMixin, FormValidMixin, FieldsMixin, CreateView):
    model = Email
    template_name = "web_page/create_update_email.html"

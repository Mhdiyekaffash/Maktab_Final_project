from django import forms
from django.contrib.auth.forms import UserCreationForm
from .models import User


class SignupForm(UserCreationForm):
    # email = forms.EmailField(max_length=200)

    class Meta:
        model = User
        fields = (
            'username', 'email', 'phone_number', 'birthday', 'gender_type', 'country_type', 'password1', 'password2')

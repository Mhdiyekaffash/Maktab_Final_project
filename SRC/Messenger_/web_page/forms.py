from django import forms
from .models import Email


class CreateEmail(forms.ModelForm):

    class Meta:
        model = Email
        fields = ['subject', 'text', 'file', 'receiver', 'label', 'sign']
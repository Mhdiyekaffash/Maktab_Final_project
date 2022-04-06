from django import forms
from django.forms import TextInput

from .models import Email, Label, ProfileContact, Signature


class CreateEmailForm(forms.ModelForm):
    class Meta:
        model = Email
        fields = ['subject', 'text', 'file', 'sign']


class EmailDetailForm(forms.ModelForm):
    class Meta:
        model = Email
        fields = ['sender', 'subject', 'text', 'file', 'receiver_to',
                  'receiver_cc', 'receiver_bcc', 'label', 'sign']


class ReplyForm(forms.ModelForm):
    class Meta:
        model = Email
        fields = ['subject', 'text']


class CreateContactForm(forms.ModelForm):
    class Meta:
        model = ProfileContact
        fields = ['first_name', 'last_name', 'email', 'profile_photo', 'phone_number'
            , 'birthday', 'other_email']


class CreateLabelForm(forms.ModelForm):
    class Meta:
        model = Label
        fields = ['title']


class SignatureModelForm(forms.ModelForm):
    class Meta:
        model = Signature
        fields = ('text',)

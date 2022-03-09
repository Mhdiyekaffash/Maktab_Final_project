from django import forms
from .models import Email, Label, ProfileContact


class CreateEmailForm(forms.ModelForm):
    class Meta:
        model = Email
        fields = ['subject', 'text', 'file', 'sign', 'is_draft']


class EmailDetailForm(forms.ModelForm):
    class Meta:
        model = Email
        fields = ['sender', 'subject', 'text', 'file', 'receiver_to',
                  'receiver_cc', 'receiver_bcc', 'label', 'sign', 'is_draft', 'is_starred', 'is_trash']


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

from django.contrib import admin
from .models import Email, Label, ProfileContact, Signature


admin.site.register(Email)
admin.site.register(Label)
admin.site.register(ProfileContact)
admin.site.register(Signature)
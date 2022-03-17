from django.contrib import admin
from .models import Email, Label, ProfileContact, Signature, EmailFolder, Filter

admin.site.register(Email)
admin.site.register(Label)
admin.site.register(ProfileContact)
admin.site.register(Signature)
admin.site.register(EmailFolder)
admin.site.register(Filter)
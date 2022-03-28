from django.contrib import admin
from .models import User


class UserAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'email', 'username', 'birthday', 'gender_type', 'country_type')
    list_filter = ('date_joined',)
    search_fields = ('username', 'first_name', 'last_name', 'gender_type')
    ordering = ('-date_joined',)


admin.site.register(User, UserAdmin)

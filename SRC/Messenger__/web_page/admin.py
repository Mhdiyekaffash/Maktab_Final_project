from django.contrib import admin

import json
from django.core.serializers.json import DjangoJSONEncoder
from django.db.models import Count
from django.db.models.functions import TruncDay, TruncMonth
from django.http import JsonResponse, HttpResponseRedirect
from django.urls import path

from account.models import User
from .models import Email, Label, ProfileContact, Signature, EmailFolder, Filter

# admin.site.register(Label)
admin.site.register(ProfileContact)
admin.site.register(Signature)
admin.site.register(EmailFolder)
admin.site.register(Filter)


@admin.register(Label)
class LabelAdmin(admin.ModelAdmin):
    fields = ('title',)
    list_display = ['user', 'title']

    def add_view(self, request):
        if request.method == "POST":
            try:
                users = User.objects.all()
                for user in users:
                    Label.objects.create(user_id=user.pk, title=request.POST.get('title'))
                return HttpResponseRedirect("/admin/web_page/label/")
            except Exception as e:
                # messages.add_message(request, messages.ERROR, message="this label exists")
                return HttpResponseRedirect('/admin/web_page/label/add/')

        return super(LabelAdmin, self).add_view(request)


@admin.register(Email)
class EmailAdmin(admin.ModelAdmin):
    list_display = ('created', 'sender', 'subject', 'text', 'file')
    ordering = ('-created',)

    def changelist_view(self, request, extra_context=None):
        # Aggregate new subscribers per day
        chart_data = (
            Email.objects.annotate(date=TruncMonth("created"))
                .values("date")
                .annotate(y=Count("id"))
                .order_by("-date")
        )

        # Serialize and attach the chart data to the template context
        as_json = json.dumps(list(chart_data), cls=DjangoJSONEncoder)
        extra_context = extra_context or {"chart_data": as_json}
        return super().changelist_view(request, extra_context=extra_context)

    def get_urls(self):
        urls = super().get_urls()
        extra_urls = [
            path("chart_data/", self.admin_site.admin_view(self.chart_data_endpoint))
        ]
        # NOTE! Our custom urls have to go before the default urls, because they
        # default ones match anything.
        return extra_urls + urls

    # JSON endpoint for generating chart data that is used for dynamic loading
    # via JS.
    def chart_data_endpoint(self, request):
        chart_data = self.chart_data()
        return JsonResponse(list(chart_data), safe=False)

    def chart_data(self):
        return (
            Email.objects.annotate(date=TruncMonth("created"))
                .values("date")
                .annotate(y=Count("id"))
                .order_by("-date")
        )

from django.http import Http404, HttpResponse
from django.shortcuts import get_object_or_404, redirect


class FieldsMixin():
    def dispatch(self, request, *args, **kwargs):
        self.fields = ['subject', 'text', 'file', 'receiver', 'label', 'sign', "slug"]
        return super().dispatch(request, *args, **kwargs)


class OwnerAccountAccessMixin():  # Only the account Owner will have access to create the email
    def dispatch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            if request.user.is_active:
                return super().dispatch(request, *args, **kwargs)
            else:
                # return redirect("account:profile")
                return HttpResponse("email na raft :( !")
        else:
            return redirect("login")


class FormValidMixin():
    def form_valid(self, form):
        if self.request.user.is_active:
            form.save()
        # else:
        #     self.obj = form.save(commit=False)
        #     self.obj.author = self.request.user
        #     if not self.obj.status == 'i':
        #         self.obj.status = 'd'
        # return super().form_valid(form)

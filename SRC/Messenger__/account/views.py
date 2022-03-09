from django.contrib.auth.views import LoginView, PasswordChangeView
from django.http import HttpResponse
from django.urls import reverse_lazy
from .forms import SignupForm
from .tokens import account_activation_token
from django.shortcuts import render, redirect
from django.views.generic import View
from django.contrib import messages
from django.contrib.sites.shortcuts import get_current_site
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode
from django.template.loader import render_to_string
from django.contrib.auth import login, authenticate, logout
from .models import User
from django.utils.encoding import force_text
from django.utils.http import urlsafe_base64_decode


# Sign Up View
class Register(View):
    form_class = SignupForm
    template_name = 'registration/register.html'

    def get(self, request, *args, **kwargs):
        form = self.form_class()
        return render(request, self.template_name, {'form': form})

    def post(self, request, *args, **kwargs):
        form = self.form_class(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.is_active = False  # Deactivate account till it is confirmed
            user.save()

            current_site = get_current_site(request)
            subject = 'Activate Your MySite Account'
            message = render_to_string('registration/activate_account.html', {
                'user': user,
                'domain': current_site.domain,
                'uid': urlsafe_base64_encode(force_bytes(user.pk)),
                'token': account_activation_token.make_token(user),
            })
            user.email_user(subject, message)

            messages.success(request, ('Please Confirm your email to complete registration.'))

            return HttpResponse('An activation link was sent to your email. <a href="/login">login</a>')

        return render(request, self.template_name, {'form': form})


class ActivateAccount(View):

    def get(self, request, uidb64, token, *args, **kwargs):
        try:
            uid = force_text(urlsafe_base64_decode(uidb64))
            user = User.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, User.DoesNotExist):
            user = None

        if user is not None and account_activation_token.check_token(user, token):
            user.is_active = True
            user.username += '@gmail.com'
            user.save()
            # login(request, user)
            messages.success(request, ('Your account have been confirmed.'))
            #     return redirect('/registration/home.html')
            # else:
            #     messages.warning(request, ('The confirmation link was invalid, possibly because it has already been used.'))
            #     return redirect('/registration/home.html')
            return HttpResponse('اکانت شما با موفقیت فعال شد. برای ورود <a href="/login">کلیک</a> کنید.')
        else:
            return HttpResponse('لینک فعال سازی منقضی شده است. <a href="/registration">دوباره امتحان کنید.</a>')


class Login(LoginView):
    def get_success_url(self):
        user = self.request.user
        if user.is_active:
            return reverse_lazy("account:home")
        else:
            return reverse_lazy("account:profile")


def logout_view(request):
    if request.method == 'POST':
        logout(request)
        return redirect("/")
    elif request.method == 'GET':
        return render(request, "registration/logged_out.html")


class PasswordChange(PasswordChangeView):
    success_url = HttpResponse('password changed')


def Profile(View):
    # model = User
    # template_name = "registration/profile.html"
    # form_class = ProfileForm
    # success_url = reverse_lazy("account:profile")
    #
    # def get_object(self):
    #     return User.objects.get(pk=self.request.user.pk)
    #
    # def get_form_kwargs(self):
    #     kwargs = super(Profile, self).get_form_kwargs()  # etesal be view
    #     kwargs.update({
    #         'user': self.request.user
    #     })
    #     return kwargs
    return HttpResponse("tamaaaaaaam :) !")


# @login_required  # if user attentication bood in view namayesh dade mishe
def home(request):
    return HttpResponse("tamaaaaaaam tammmaaaaaaaaaaaaaam :) !")

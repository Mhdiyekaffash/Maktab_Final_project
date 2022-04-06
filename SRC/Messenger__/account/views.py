from django.contrib.auth.decorators import login_required
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
import logging

logger = logging.getLogger('account')


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
            logger.info(f"account {user} Added.")
            return HttpResponse('An activation link was sent to your email. <a href="/login">login</a>')

        logger.error(f"register form is not valid.")
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
            messages.success(request, ('Your account have been confirmed.'))
            logger.info(f"this {user} has been successfully activated.")
            return HttpResponse('Your account has been successfully activated. <a  href="/login">click </a> ')
        else:
            logger.error(f"Activation link has expired. for {user}")
            return HttpResponse('Activation link has expired.  <a href="/signup">Please try again.</a>')


class Login(LoginView):
    def get_success_url(self):
        user = self.request.user
        if user.is_active:
            return reverse_lazy("account:home")
        else:
            logger.warning(f"{user} try to login but this account is not active")
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
    return HttpResponse("don't ready :( !")


def home(request):
    return redirect('/')

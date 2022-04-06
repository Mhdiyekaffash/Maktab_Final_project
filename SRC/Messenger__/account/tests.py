from django.test import TestCase
from .models import User
from .forms import SignupForm
from django.urls import reverse


# Create your tests here.
class AccountTest(TestCase):

    def test_signup_form(self):
        form = SignupForm(
            data={'username': 'samie', 'email': 'samie@gmail.com', 'password1': 'abcd1309**',
                  'password2': 'abcd1309**'})
        self.assertTrue(form.is_valid())
        self.assertEqual(form.data['password1'], form.data['password2'])

    def test_login(self):
        response = self.client.get(reverse('account:home'), follow=True)
        self.assertEqual(response.status_code, 200)

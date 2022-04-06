from django.test import TestCase
from django.urls import reverse

from .models import ProfileContact, Email, User, Label, EmailFolder, Signature
from .forms import CreateContactForm
import unittest
from django.test import Client


# Create your tests here.
class ContactTest(TestCase):

    def setUp(self):
        c1 = ProfileContact.objects.create(first_name="Ali", last_name="Bostani", email='Ali@gmail.com')
        c2 = ProfileContact.objects.create(first_name="Ali2", last_name="Bostani", email='Ali2@gmail.com')

    def test_valid_email_contact(self):
        q = ProfileContact.objects.get(first_name="Ali")
        self.assertEqual("@gmail.com", q.email[-10:])

    def test_uniq_email_contact(self):
        c = ProfileContact.objects.get(first_name="Ali").email
        c2 = ProfileContact.objects.get(first_name="Ali2").email
        self.assertTrue(bool(c != c2))

    def test_create_contact(self):
        form = CreateContactForm(
            data={'first_name': 'mahdiye', 'last_name': 'kaffash', 'email': 'kaffashmhdiye@gmail.com'})
        self.assertTrue(form.is_valid())

    def test_search_contact(self):
        text = 'Ali2'
        c = ProfileContact.objects.get(first_name='Ali2').first_name
        result = list(ProfileContact.objects.filter(first_name__startswith=text).values_list('first_name', flat=True))[
            0]
        self.assertEqual(c, result)


class ContactListTest(unittest.TestCase):
    def setUp(self):
        self.client = Client()
        person1 = ProfileContact.objects.create(first_name="Person 1", last_name="k1",
                                                email='mim_k1@gmail.com')
        person2 = ProfileContact.objects.create(first_name="Person 2", last_name="k2",
                                                email='mim_k4@gmail.com')

    def test_details(self):
        def test_contact_list(self):
            response = self.client.get(reverse('web_page:ContactList'))
            self.assertIn('environment', response.context)


# class TestDifferentRequestMethods(TestCase):  # *****
#
#     def test_my_get_request(self):
#         myobject = ProfileContact.objects.create(first_name="Mim3", last_name="k5",
#                                                  email='min_shin5@gmail.com')
#         response = self.client.get(f'http://127.0.0.1:8000/web_page/deletecontact/{myobject.pk}')
#         self.assertContains(response, 'Are you sure you want to delete')
#
#     def test_my_post_request(self):
#         myobject = ProfileContact.objects.get(first_name="Mim3")
#         post_response = self.client.post(reverse('delete_contact', args=(myobject.pk,)))
#         self.assertRedirects(post_response, reverse('/'), status_code=302)


# ---------------------- Email

class EmailTest(TestCase):

    def setUp(self):
        u = User.objects.create(username="eli@gmail.com", is_active=True)
        u.set_password('ab654321')
        u.save()
        e = Email.objects.create(sender=u, subject='tft')
        e2 = Email.objects.create(sender=u, pk=0)
        e3 = Email.objects.create(sender=u, subject='e3')
        e4 = Email.objects.create(sender=u, subject='e4')
        folder_e4 = EmailFolder.objects.create(user=u, email=e4, is_archive=True)

        e.receiver_to.add(u.id)
        e_trash = Email.objects.create(sender=u, subject='trash')
        folder_e_trash = EmailFolder.objects.create(user=u, email=e_trash, is_trash=True)

    def test_receiver_to(self):
        e = Email.objects.get(subject='tft')
        self.assertTrue(bool(e.receiver_to))

    def test_detail_email(self):
        e2 = Email.objects.get(pk=0)
        response = self.client.get(f'/web_page/email-detail/{e2.pk}', follow=True)
        self.assertEqual(response.status_code, 200)

    def test_delete_email(self):
        e3 = Email.objects.get(subject='e3')
        response = self.client.get(f'/web_page/emaildelete/{e3.pk}', follow=True)
        self.assertEqual(response.status_code, 200)

    def test_check_archive(self):
        e4 = Email.objects.get(subject='e4')
        folder_e4 = EmailFolder.objects.get(email=e4)

        response = self.client.get(f'/web_page/archive/', follow=True)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(folder_e4.is_archive, True)

    def test_check_trash(self):
        e_trash = Email.objects.get(subject='trash')
        folder_e_trash = EmailFolder.objects.get(email=e_trash)

        response = self.client.get('/web_page/trash/', follow=True)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(folder_e_trash.is_trash, True)


class EmailListTest(unittest.TestCase):
    def setUp(self):
        self.client = Client()
        u = User.objects.create(username="reyhan@gmail.com", password='ab123456', is_active=True)
        email_1 = Email.objects.create(sender=u)
        email_2 = Email.objects.create(sender=u)

    def test_details(self):
        def test_label_list(self):
            response = self.client.get(reverse('/'))
            self.assertIn('environment', response.context)


# ---------------------------- Label

class Labeltest(TestCase):

    def setUp(self):
        u = User.objects.create(username="eli2@gmail.com", password='ab123456', is_active=True)
        label_1 = Label.objects.create(user=u, title='sea', slug='sea')
        label_2 = Label.objects.create(user=u, title='blue', slug='blue')

    def test_detail_label(self):
        label_1 = Label.objects.get(slug='sea')
        response = self.client.get(f'/web_page/label-Detail/{label_1.slug}', follow=True)
        self.assertEqual(response.status_code, 200)

    def test_delete_label(self):
        label_2 = Label.objects.get(slug='blue')
        response = self.client.get(f'/web_page/label-Delete/{label_2.slug}', follow=True)
        self.assertEqual(response.status_code, 200)

    def test_search_label(self):
        text = 'sea'
        l = Label.objects.get(title='sea').title
        result = list(Label.objects.filter(title__startswith=text).values_list('title', flat=True))[0]
        self.assertEqual(l, result)


class LabelListTest(unittest.TestCase):
    def setUp(self):
        self.client = Client()
        u = User.objects.create(username="pouya@gmail.com", password='ab123456', is_active=True)
        label_1 = Label.objects.create(user=u, title='sea2', slug='sea2')
        label_2 = Label.objects.create(user=u, title='blue2', slug='blue2')

    def test_details(self):
        def test_label_list(self):
            response = self.client.get(reverse('web_page:LabelList'))
            self.assertIn('environment', response.context)


# ---------------------------- Signature

class SignatureTest(TestCase):

    def setUp(self):
        u = User.objects.create(username="mahdiye2@gmail.com", password='ab123456', is_active=True)
        s = Signature.objects.create(user=u, text='sea')
        s = Signature.objects.create(user=u, text='sky')

    def test_detail_signature(self):
        sign = Signature.objects.get(text='sky')
        response = self.client.get(f'/web_page/signature-detail/{sign.pk}', follow=True)
        self.assertEqual(response.status_code, 200)

    def test_delete_signature(self):
        sign = Signature.objects.get(text='sky')
        response = self.client.get(f'/web_page/signature_delete/{sign.pk}', follow=True)
        self.assertEqual(response.status_code, 200)


class SignatureListTest(unittest.TestCase):
    def setUp(self):
        self.client = Client()
        u = User.objects.create(username="mahdiye3@gmail.com", password='ab123456', is_active=True)
        s = Signature.objects.create(user=u, text='sea2')
        s = Signature.objects.create(user=u, text='sky2')

    def test_details(self):
        def test_contact_list(self):
            response = self.client.get(reverse('mail:signatures'))
            self.assertIn('environment', response.context)

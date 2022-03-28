import csv
import itertools
import json

from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.mixins import LoginRequiredMixin
from django.db.models import Q
from django.http import HttpResponse, HttpResponseRedirect
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.utils import timezone
from django.views import View
from django.views.generic import DetailView, DeleteView, UpdateView

from account.models import User
from .models import Email, ProfileContact, Label, Signature, Filter, EmailFolder
from .forms import CreateEmailForm, ReplyForm, CreateContactForm, CreateLabelForm, SignatureModelForm

from rest_framework import generics, viewsets
from rest_framework import status

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import permissions
from .serializer import ContactSerializer, EmailSerializer

"""
<----- Email section ----->
    CreateEmail, DisplayAllEmail, DisplayDetailEmail, Replay, Forward, Send Draft
"""


class CreateEmail(LoginRequiredMixin, View):

    def get(self, request):
        form = CreateEmailForm()
        id = request.user.id
        contacts = User.objects.get(id=id).contact_user.all().values_list('email', flat=True)
        signature_list = Signature.objects.filter(user=request.user).values_list('text', flat=True)
        return render(request, 'web_page/create_email.html', {"form": form,
                                                              'contacts': list(contacts),
                                                              'signature_list': list(signature_list)})

    def post(self, request):

        global user_logined
        form = CreateEmailForm(request.POST, request.FILES)

        receiver_to = request.POST["to"]  # Taken from the input
        receiver_cc = request.POST["cc"]  # ☝
        receiver_bcc = request.POST["bcc"]  # ☝

        if request.POST.get('selected_singature') != 'None':
            signature = Signature.objects.get(text=request.POST['selected_singature'], user=request.user)
        else:
            signature = None

        if receiver_to is None:
            messages.add_message(request, messages.ERROR,
                                 f'receiver to dont empty')
            return HttpResponseRedirect("/")

        # The values taken from the input are comma separated and created as a list of recipients
        to_list = receiver_to.split(',')
        cc_list = receiver_cc.split(',')
        bcc_list1 = receiver_bcc.split(',')

        receivers = to_list + cc_list + bcc_list1
        receivers = [i for i in receivers if i]

        for i in to_list:
            if i == '':
                messages.add_message(request, messages.ERROR, 'to is empty 🤷‍️')
                return HttpResponseRedirect("/")

        users = User.objects.all().values_list('username', flat=True)

        users_list = [i for i in users]  # List of all users who have an account on the site

        to_list = [i for i in to_list if i in users_list]  # List of all recipients (to) who have an account on the site
        cc_list = [i for i in cc_list if i in users_list]  # ☝  (cc)
        bcc_list = [i for i in bcc_list1 if i in users_list]  # ☝  (bcc)

        for i in receivers:
            if i not in users_list:
                messages.add_message(request, messages.WARNING,
                                     f"Sorry, there is no user with this {i} account. 🤔")
                return HttpResponseRedirect("/")

        # List of id all recipients who have an account on the site 👇
        list_id_to = [User.objects.get(username=i).id for i in to_list]
        list_id_cc = [User.objects.get(username=i).id for i in cc_list]
        list_id_bcc = [User.objects.get(username=i).id for i in bcc_list]

        if form.is_valid():
            user_login = User.objects.get(id=request.user.id)
            email = Email(subject=form.cleaned_data['subject'],
                          text=form.cleaned_data['text'],
                          file=form.cleaned_data['file'],
                          sign=signature,
                          sender=user_login)

            email.save()

            # For when we do not want to send the message and want to stay in the draft file 👇
            if 'draft' in request.POST:

                EmailFolder(user=user_login, email=email, is_draft=True).save()

                return redirect('/web_page/draft/')

            # For when we want to send the message 👇
            else:

                # Recipients are added to the email object one by one based on their ideas 👇
                email.receiver_to.add(*list_id_to)
                email.receiver_cc.add(*list_id_cc)
                email.receiver_bcc.add(*list_id_bcc)

                EmailFolder(user=user_login, email=email).save()

                for receiver in to_list:
                    user_logined = User.objects.get(username=receiver)
                    EmailFolder(user=user_logined, email=email).save()
                    filters = Filter.objects.filter(owner=user_logined)
                    for filter in filters:
                        if str(filter.filter_by) in email.subject or str(filter.filter_by) in email.text \
                                or str(filter.filter_by) in email.sender.username:
                            email.filter.add(filter)
                            email.label.add(filter.label)

                            if filter.label.title == 'Trash':
                                email_folders = EmailFolder.objects.filter(email=email.pk, user=user_logined)
                                for i in email_folders:
                                    i.is_trash = True
                                    i.save()

                            if filter.label.title == 'Archive':
                                email_folders = EmailFolder.objects.filter(email=email.pk, user=user_logined)
                                for i in email_folders:
                                    i.is_archive = True
                                    i.save()

                for receiver in cc_list:
                    user_logined = User.objects.get(username=receiver)
                    EmailFolder(user=user_logined, email=email).save()
                    filters = Filter.objects.filter(owner=user_logined)
                    for filter in filters:
                        if str(filter.filter_by) in email.subject or str(filter.filter_by) in email.text \
                                or str(filter.filter_by) in email.sender.username:
                            email.filter.add(filter)
                            email.label.add(filter.label)

                            if filter.label.title == 'Trash':
                                email_folders = EmailFolder.objects.filter(email=email.pk, user=user_logined)
                                for i in email_folders:
                                    i.is_trash = True
                                    i.save()

                            if filter.label.title == 'Archive':
                                email_folders = EmailFolder.objects.filter(email=email.pk, user=user_logined)
                                for i in email_folders:
                                    i.is_archive = True
                                    i.save()

                for receiver in bcc_list:
                    user_logined = User.objects.get(username=receiver)
                    EmailFolder(user=user_logined, email=email).save()
                    filters = Filter.objects.filter(owner=user_logined)
                    for filter in filters:
                        if str(filter.filter_by) in email.subject or str(filter.filter_by) in email.text \
                                or str(filter.filter_by) in email.sender.username:
                            email.filter.add(filter)
                            email.label.add(filter.label)

                            if filter.label.title == 'Trash':
                                email_folders = EmailFolder.objects.filter(email=email.pk, user=user_logined)
                                for i in email_folders:
                                    i.is_trash = True
                                    i.save()

                            if filter.label.title == 'Archive':
                                email_folders = EmailFolder.objects.filter(email=email.pk, user=user_logined)
                                for i in email_folders:
                                    i.is_archive = True
                                    i.save()

                messages.add_message(request, messages.SUCCESS,
                                     f'email sent successfully. 😊👌')
                return redirect('/')

        messages.error(request, form.errors)
        return redirect('/')


class DisplayAllEmail(LoginRequiredMixin, View):

    def get(self, request):

        # query for display emails 👇
        emails = Email.objects.all().filter((Q(sender=request.user.id) | Q(receiver_to=request.user.id)
                                             | Q(receiver_cc=request.user.id) | Q(receiver_bcc=request.user.id)
                                             )).distinct()

        for e in emails:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:
                if i.is_trash is True or i.is_archive is True or i.is_draft is True:
                    emails = emails.exclude(pk=e.pk)

        # query message for receiver 👇
        emails_ = Email.objects.all().filter(Q(receiver_to=request.user) | Q(receiver_cc=request.user)
                                             | Q(receiver_bcc=request.user))

        for email in emails_:
            if request.user.last_login <= email.created <= timezone.now():
                messages.add_message(request, messages.SUCCESS,
                                     f'An email was sent to you by {email.sender} on the {email.created}'
                                     f'with subject --> {email.subject}')

        return render(request, 'web_page/email_list.html', {'emails': emails})


class DisplayDetailEmail(LoginRequiredMixin, DetailView):
    model = Email

    def get_context_data(self, **kwargs):
        context = super(DisplayDetailEmail, self).get_context_data(**kwargs)
        if context['object'].label:
            context['labels'] = list(
                context['object'].label.filter(user_id=self.request.user.pk))

        places = list(EmailFolder.objects.filter(email=context['object'].pk,
                                                 user_id=self.request.user.pk))
        context['places'] = places

        if context['object'].filter:
            context['filters'] = list(context['object'].filter.filter(owner_id=self.request.user.pk))

        return context


class EmailDelete(LoginRequiredMixin, DeleteView):
    model = Email
    success_url = '/'


class AddLabel(View):

    def get(self, request, pk):
        query = Label.objects.filter(user=request.user).values_list('title', flat=True)
        return render(request, 'web_page/add_label_to_email.html', {'query': list(query)})

    def post(self, request, pk):
        label = request.POST.getlist('selected_label')
        email = Email.objects.get(id=pk)
        label_id = [Label.objects.get(title=i) for i in label]
        email.label.add(*label_id)
        return HttpResponse('okay!')


class ReplyEmail(LoginRequiredMixin, View):

    def get(self, request, pk):
        form = ReplyForm()
        replied_email = Email.objects.get(id=pk)
        return render(request, 'web_page/reply.html',
                      {'form': form, 'replied_email': replied_email})

    def post(self, request, pk):
        form = ReplyForm(request.POST)
        if form.is_valid():
            replier = request.user
            email = Email.objects.get(id=pk)
            email_object = Email(sender=replier, subject=form.cleaned_data['subject'],
                                 text=form.cleaned_data['text'])

            email_object.email_obj = email
            email_object.save()
            email_object.receiver_to.add(email.sender.id)

            EmailFolder(user=email.sender, email=email_object).save()
            EmailFolder(user=replier, email=email_object).save()

            messages.add_message(request, messages.SUCCESS,
                                 f'email replayed. 😊👌')

            return redirect('/')
        return HttpResponse('🤔')


class Forward(LoginRequiredMixin, View):

    def get(self, request, pk):
        email = Email.objects.get(id=pk)
        id = request.user.id
        contacts = User.objects.get(id=id).contact_user.all().values_list('email', flat=True)
        return render(request, 'web_page/forward.html',
                      {'contacts': list(contacts), 'email': email})

    def post(self, request, pk):

        forwarder = request.user
        email = Email.objects.get(id=pk)
        receiver_to = request.POST["to"]
        receiver_cc = request.POST["cc"]
        receiver_bcc = request.POST["bcc"]

        # The values taken from the input are comma separated and created as a list of recipients
        to_list = receiver_to.split(',')
        cc_list = receiver_cc.split(',')
        bcc_list = receiver_bcc.split(',')

        users = User.objects.all().values_list('username', flat=True)
        users_list = [i for i in users]  # List of all users who have an account on the site

        # List of all recipients (to) who have an account on the site
        to_list = [i for i in to_list if i in users_list]
        cc_list = [i for i in cc_list if i in users_list]  # ☝  (cc)
        bcc_list = [i for i in bcc_list if i in users_list]  # ☝  (bcc)

        # List of id all recipients who have an account on the site 👇
        list_id_to = [User.objects.get(username=i).id for i in to_list]
        list_id_cc = [User.objects.get(username=i).id for i in cc_list]
        list_id_bcc = [User.objects.get(username=i).id for i in bcc_list]

        email_forwarded = Email(subject=email.subject,
                                text=email.text,
                                sender=forwarder)

        email_forwarded.save()

        # Recipients are added to the email object one by one based on their ideas 👇
        email_forwarded.receiver_to.add(*list_id_to)
        email_forwarded.receiver_cc.add(*list_id_cc)
        email_forwarded.receiver_bcc.add(*list_id_bcc)

        EmailFolder(user=forwarder, email=email_forwarded).save()

        for receiver in to_list:
            EmailFolder(user=User.objects.get(username=receiver), email=email_forwarded).save()
        for receiver in cc_list:
            EmailFolder(user=User.objects.get(username=receiver), email=email_forwarded).save()
        for receiver in bcc_list:
            EmailFolder(user=User.objects.get(username=receiver), email=email_forwarded).save()

        messages.add_message(request, messages.SUCCESS,
                             f'email Forwarded. 😊👌')
        return redirect('/')


class SendDraft(LoginRequiredMixin, View):

    def get(self, request, pk):
        email = Email.objects.get(id=pk)
        id = request.user.id
        contacts = User.objects.get(id=id).contact_user.all().values_list('email', flat=True)
        return render(request, 'web_page/forward.html',
                      {'contacts': list(contacts), 'email': email})

    def post(self, request, pk):

        forwarder = request.user

        email = Email.objects.get(id=pk)

        receiver_to = request.POST["to"]
        receiver_cc = request.POST["cc"]
        receiver_bcc = request.POST["bcc"]

        # The values taken from the input are comma separated and created as a list of recipients
        to_list = receiver_to.split(',')
        cc_list = receiver_cc.split(',')
        bcc_list = receiver_bcc.split(',')

        users = User.objects.all().values_list('username', flat=True)
        users_list = [i for i in users]  # List of all users who have an account on the site

        # List of all recipients (to) who have an account on the site
        to_list = [i for i in to_list if i in users_list]
        cc_list = [i for i in cc_list if i in users_list]  # ☝  (cc)
        bcc_list = [i for i in bcc_list if i in users_list]  # ☝  (bcc)

        # List of id all recipients who have an account on the site 👇
        list_id_to = [User.objects.get(username=i).id for i in to_list]
        list_id_cc = [User.objects.get(username=i).id for i in cc_list]
        list_id_bcc = [User.objects.get(username=i).id for i in bcc_list]

        # Recipients are added to the email object one by one based on their ideas 👇
        email.receiver_to.add(*list_id_to)
        email.receiver_cc.add(*list_id_cc)
        email.receiver_bcc.add(*list_id_bcc)

        place = EmailFolder.objects.get(email=email.pk, user=request.user)
        place.is_draft = False
        place.save(update_fields=['is_draft'])

        for receiver in to_list:
            EmailFolder(user=User.objects.get(username=receiver), email=email).save()
        for receiver in cc_list:
            EmailFolder(user=User.objects.get(username=receiver), email=email).save()
        for receiver in bcc_list:
            EmailFolder(user=User.objects.get(username=receiver), email=email).save()

        messages.add_message(request, messages.SUCCESS,
                             f'email sent successfully. 😊👌')

        return redirect('/')


class EmailsList(APIView):  # Emails List for any User
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, *args, **kwargs):
        emails = Email.objects.all().filter(Q(sender=request.user) | Q(receiver_bcc=request.user) |
                                            Q(receiver_cc=request.user) | Q(receiver_to=request.user))
        x = EmailSerializer(emails, many=True)  # serializer(queryset)
        return Response({
            'emails': x.data
        })


# <------ start Contact section ------>

class CreateContact(LoginRequiredMixin, View):

    def get(self, request):
        form = CreateContactForm()
        return render(request, 'web_page/create_contact.html', {"form": form})

    def post(self, request):
        form = CreateContactForm(request.POST, request.FILES)
        if form.is_valid():
            user = request.user
            contact_obj = ProfileContact(first_name=form.cleaned_data['first_name'],
                                         last_name=form.cleaned_data['last_name'],
                                         email=form.cleaned_data['email'],
                                         profile_photo=form.cleaned_data['profile_photo'],
                                         phone_number=form.cleaned_data['phone_number'],
                                         birthday=form.cleaned_data['birthday'],
                                         user=user,
                                         other_email=form.cleaned_data['other_email'])
            contact_obj.save()

            return redirect(f'/web_page/ContactList')
        return HttpResponse(f"'not saved', {form.errors}")


class ContactList(LoginRequiredMixin, View):

    def get(self, request):
        contacts = ProfileContact.objects.all().filter(user=request.user)

        return render(request, 'web_page/profilecontact_list.html', {'contacts': contacts})


class ContactDetail(LoginRequiredMixin, DetailView):
    model = ProfileContact
    template_name = 'web_page/profilecontact_detail.html'


class DeleteContact(LoginRequiredMixin, DeleteView):
    model = ProfileContact
    success_url = '/'


class UpdateContact(LoginRequiredMixin, UpdateView):
    model = ProfileContact
    template_name = 'web_page/edite_contact.html'
    fields = ['first_name', 'last_name', 'email', 'phone_number', 'birthday', 'other_email']
    success_url = '/'


class SearchContacts(LoginRequiredMixin, View):  # search contact without ajax

    def get(self, request):
        contacts = ProfileContact.objects.all().filter(user=request.user).values_list('first_name', 'last_name',
                                                                                      'email', 'phone_number',
                                                                                      'other_email')

        contacts_list = list(itertools.chain(*list(contacts)))
        res = [i for i in contacts_list if i]

        return render(request, 'web_page/search_contacts.html', {'res': res})

    def post(self, request):
        contact = request.POST['contact']
        result = ProfileContact.objects.all().filter(Q(user=request.user) & (
                Q(first_name__startswith=contact) | Q(last_name__startswith=contact) |
                Q(email__startswith=contact) | Q(phone_number__startswith=contact)
                | Q(other_email__startswith=contact)))

        return render(request, 'web_page/contacts_result.html', {'result': result})


@login_required  # search contact by ajax
def search_content_contact(req):
    if req.method == 'POST':
        text = req.POST.get('text')
        if not text:
            json_data = json.loads(req.body)
            text = json_data['text']

        contact = ProfileContact.objects.all().filter(Q(user=req.user) & (
                Q(first_name__contains=text) | Q(last_name__contains=text) |
                Q(email__contains=text) | Q(phone_number__contains=text, phone_number__isnull=False)
                | Q(other_email__contains=text, other_email__isnull=False)))

        contact_list = list(contact.values('first_name', 'last_name', 'email', 'pk'))

        if contact:
            return JsonResponse({
                'contacts': contact_list,
            })
        else:
            return JsonResponse({
                'contacts': [],
                'msg': "doesn't match any emails",
            })
    else:
        return render(req, 'web_page/search_content_contact_box.html', {})


class ContactsList(APIView):  # Contacts List for any User
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, *args, **kwargs):
        contacts = ProfileContact.objects.all().filter(user=request.user)  # queryset
        x = ContactSerializer(contacts, many=True)  # serializer(queryset)
        return Response({
            'contacts': x.data
        })


# <------ start Label section ------>

class CreateLabel(LoginRequiredMixin, View):

    def get(self, request):
        form = CreateLabelForm()
        return render(request, 'web_page/create_label.html', {"form": form})

    def post(self, request):
        form = CreateLabelForm(request.POST, request.FILES)
        if form.is_valid():
            label_obj = Label(title=form.cleaned_data['title'],
                              user=request.user)

            label_obj.save()
            return redirect(f'/web_page/labe-lList/')
        return HttpResponse(f"'not saved', {form.errors}")


class LabelList(LoginRequiredMixin, View):

    def get(self, request):
        labels = Label.objects.all().filter(user=request.user.id)

        return render(request, 'web_page/label_list.html', {'labels': labels})


class LabelDetail(LoginRequiredMixin, DetailView):
    model = Label


class LabelDelete(LoginRequiredMixin, DeleteView):
    model = Label
    success_url = '/'


class SearchByLabel(LoginRequiredMixin, View):

    def get(self, request):
        labels = Label.objects.all().filter(user=request.user.id).values_list('title', flat=True)
        return render(request, 'web_page/search_by_label.html', {'labels': list(labels)})

    def post(self, request):
        label_input = request.POST['search']
        emails = Email.objects.all().filter(
            Q(label__title__startswith=label_input) & Q(sender=request.user.id)
            | Q(receiver_to=request.user.id) | Q(receiver_cc=request.user.id) |
            Q(receiver_bcc=request.user.id)).distinct()
        return render(request, 'web_page/result_search.html', {'emails': emails})


"""
<------ start Categories section ------>

   Sent Draft Archive Trash
"""


class SentBox(LoginRequiredMixin, View):

    def get(self, request):
        emails = Email.objects.filter(sender=request.user.id).distinct()

        for e in emails:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:
                if i.is_trash or i.is_draft is True:
                    emails = emails.exclude(pk=e.pk)

        return render(request, 'web_page/sentbox.html', {'emails': emails})


class Inbox(LoginRequiredMixin, View):

    def get(self, request):

        emails_to = Email.objects.filter(receiver_to=request.user.id).distinct()
        for e in emails_to:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:

                if i.is_trash is True or i.is_draft is True or i.is_archive is True:
                    emails_to = emails_to.exclude(pk=e.pk)

        emails_cc = Email.objects.filter(receiver_cc=request.user.id).distinct()
        for e in emails_to:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:
                if i.is_trash is True or i.is_draft is True or i.is_archive is True:
                    emails_cc = emails_cc.exclude(pk=e.pk)

        emails_bcc = Email.objects.filter(receiver_bcc=request.user.id).distinct()
        for e in emails_to:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:
                if i.is_trash is True or i.is_draft is True or i.is_archive is True:
                    emails_bcc = emails_bcc.exclude(pk=e.pk)

        return render(request, 'web_page/inbox.html', {'emails_to': emails_to,
                                                       'emails_cc': emails_cc,
                                                       'emails_bcc': emails_bcc})


class Draft(LoginRequiredMixin, View):

    def get(self, request):
        emails = Email.objects.filter(sender=request.user.pk, receiver_cc=None, receiver_bcc=None, receiver_to=None)
        for e in emails:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:
                if i.is_draft is False or i.is_archive is True or i.is_trash is True:
                    emails = emails.exclude(pk=e.pk)
        return render(request, 'web_page/draft.html', {'emails_drafted': emails})


class Archive(LoginRequiredMixin, View):

    def get(self, request):
        emails = Email.objects.filter(Q(sender=request.user.pk) | Q(receiver_bcc=request.user.pk) |
                                      Q(receiver_cc=request.user.pk) | Q(receiver_to=request.user.pk))
        for e in emails:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:
                if i.is_trash is True or i.is_archive is False:
                    emails = emails.exclude(pk=e.pk)
        return render(request, 'web_page/archive.html', {'emails_archived': emails})


class Trash(LoginRequiredMixin, View):

    def get(self, request):
        emails = Email.objects.filter(Q(sender=request.user.pk) | Q(receiver_bcc=request.user.pk) |
                                      Q(receiver_cc=request.user.pk) | Q(receiver_to=request.user.pk))
        for e in emails:
            email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
            for i in email_folder:
                if i.is_trash is False:
                    emails = emails.exclude(pk=e.pk)
        return render(request, 'web_page/trash.html', {'emails_trashed': emails})


@login_required(redirect_field_name='login')
def check_archive(request, pk):
    if request.method == "GET":
        email = Email.objects.get(pk=pk)
        places = EmailFolder.objects.filter(user=request.user.pk, email=email.pk)
        for place in places:
            if place.is_archive is False:
                place.is_archive = True
            elif place.is_archive is True:
                place.is_archive = False
            place.save(update_fields=['is_archive'])
        return redirect('archive')


@login_required(redirect_field_name='login')
def check_trash(request, pk):
    if request.method == "GET":
        email = Email.objects.get(pk=pk)
        places = EmailFolder.objects.filter(user=request.user.pk, email=email.pk)
        for place in places:
            if place.is_trash is False:
                place.is_trash = True
                place.is_draft = False
            elif place.is_trash is True:
                place.is_trash = False
            place.save(update_fields=['is_trash'])
        return redirect('trash')


#  <---------- Signature ----------->


class CreateSignature(LoginRequiredMixin, View):

    def get(self, request):
        form = SignatureModelForm()
        return render(request, 'web_page/create_signature.html', {"form": form})

    def post(self, request):
        form = SignatureModelForm(request.POST, request.FILES)
        if form.is_valid():
            signature_obj = Signature(text=form.cleaned_data['text'],
                                      user=request.user)
            signature_obj.save()
            return HttpResponse('this signature created')


class SignatureList(LoginRequiredMixin, View):
    def get(self, request):
        signatures = Signature.objects.all().filter(user=request.user)
        return render(request, 'web_page/signature_list.html', {'signatures': signatures})


class SignatureDetail(LoginRequiredMixin, DetailView):
    model = Signature


def exportcsv(request):  # Download List Contacts ---> Csv
    contacts = ProfileContact.objects.all().filter(user=request.user)
    response = HttpResponse('')
    response['Content-Disposition'] = 'attachment; filename=contacts.csv'
    writer = csv.writer(response)
    writer.writerow(['first_name', 'last_name', 'email', 'other_email', 'phone_number', 'birthday'])
    contacts = contacts.values_list('first_name', 'last_name', 'email', 'other_email', 'phone_number', 'birthday')
    for contact in contacts:
        writer.writerow(contact)
    return response


@login_required
def search_content_email(req):
    if req.method == 'POST':
        text = req.POST.get('text')
        if not text:
            json_data = json.loads(req.body)
            text = json_data['text']

        email = Email.objects.filter((Q(subject__contains=text, subject__isnull=False) |
                                      Q(text__contains=text, text__isnull=False))
                                     & (Q(sender=req.user) |
                                        Q(receiver_to=req.user)
                                        | Q(receiver_cc=req.user)
                                        | Q(receiver_bcc=req.user)))
        email_list = list(email.values('text', 'subject', 'pk'))

        if email:
            return JsonResponse({
                'emails': email_list,
            })
        else:
            return JsonResponse({
                'emails': [],
                'msg': "doesn't match any emails",
            })
    else:
        return render(req, 'web_page/search_content_email_box.html', {})


class FilterEmail(LoginRequiredMixin, View):

    def get(self, request):

        query = Label.objects.filter(user=request.user).values_list('title', flat=True)
        if 'Trash' not in list(query):
            Label.objects.create(title='Trash', user=request.user)

        if 'Archive' not in list(query):
            Label.objects.create(title='Archive', user=request.user)

        query = Label.objects.filter(user=request.user).values_list('title', flat=True)
        return render(request, 'web_page/filter_email.html', {'query': list(query)})

    def post(self, request):

        if 'sender' in request.POST:
            search_input = request.POST['sender']
            users = User.objects.all().values_list('username', flat=True)
            users_list = [i for i in users]
            if search_input in users_list:
                query = Email.objects.filter(
                    Q(sender=User.objects.get(username=search_input)) & (Q(receiver_to=request.user) |
                                                                         Q(receiver_cc=request.user) |
                                                                         Q(receiver_bcc=request.user)))
                for e in query:
                    email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
                    for i in email_folder:
                        if i.is_trash is True:
                            query = query.exclude(pk=e.pk)

                label = request.POST['selected_label']
                selected_label = Label.objects.filter(title=label)[0]
                filter = Filter(label=selected_label, owner=request.user, filter_by=search_input)
                filter.save()
                for i in query:
                    i.filter.add(filter.id)
                    i.label.add(selected_label.id)

                for email in query:
                    places = EmailFolder.objects.filter(email=email.pk, user=request.user)
                    for place in places:
                        if label == 'Trash':
                            place.is_trash = True
                            place.save()
                        if label == 'Archive':
                            place.is_archive = True
                            place.save()

                return render(request, 'web_page/emails_filterd.html', {'query': list(query)})

        if 'word' in request.POST:
            search_input = request.POST['word']

            query = Email.objects.filter((Q(subject__contains=search_input) | Q(text__contains=search_input)) &
                                         (Q(receiver_to=request.user) |
                                          Q(receiver_cc=request.user) |
                                          Q(receiver_bcc=request.user)))

            for e in query:
                email_folder = EmailFolder.objects.filter(email=e.pk, user=request.user.pk)
                for i in email_folder:
                    if i.is_trash is True:
                        query = query.exclude(pk=e.pk)
            label = request.POST['selected_label']
            selected_label = Label.objects.filter(title=label)[0]
            filter = Filter(label=selected_label, owner=request.user, filter_by=search_input)
            filter.save()
            for i in query:
                i.filter.add(filter.id)
                i.label.add(selected_label.id)

            for email in query:
                places = EmailFolder.objects.filter(email=email.pk, user=request.user)
                for place in places:
                    if label == 'Trash':
                        place.is_trash = True
                        place.save()
                    if label == 'Archive':
                        place.is_archive = True
                        place.save()

            return render(request, 'web_page/emails_filterd.html', {'query': list(query)})

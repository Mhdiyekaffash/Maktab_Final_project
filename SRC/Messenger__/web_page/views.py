from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.views import View
from django.views.generic import ListView, DetailView, DeleteView, UpdateView
from account.models import User
from .forms import CreateEmailForm, ReplyForm, CreateContactForm, CreateLabelForm
from .models import Email, ProfileContact, Label


# -----> Email section

class CreateEmail(LoginRequiredMixin, View):

    def get(self, request):
        form = CreateEmailForm()
        id = request.user.id
        contacts = User.objects.get(id=id).contact_user.all().values_list('email', flat=True)
        labels = Label.objects.all().values_list('title', flat=True)
        return render(request, 'web_page/create_email.html', {"form": form,
                                                              'contacts': list(contacts),
                                                              'labels': list(labels)})

    def post(self, request):
        form = CreateEmailForm(request.POST, request.FILES)
        receiver_to = request.POST["to"]
        receiver_cc = request.POST["cc"]
        receiver_bcc = request.POST["bcc"]
        label = request.POST["label"]
        if form.is_valid():
            user_login = User.objects.get(id=request.user.id)
            email = Email(subject=form.cleaned_data['subject'],
                          text=form.cleaned_data['text'],
                          file=form.cleaned_data['file'],
                          sign=form.cleaned_data['sign'],
                          is_draft=form.cleaned_data['is_draft'],
                          sender=user_login)
            email.save()
            to_pk = User.objects.get(username=receiver_to).id
            cc_pk = User.objects.get(username=receiver_cc).id
            bcc_pk = User.objects.get(username=receiver_bcc).id
            label_pk = Label.objects.get(title=label).id
            email.receiver_to.add(to_pk)
            email.receiver_cc.add(cc_pk)
            email.receiver_bcc.add(bcc_pk)
            email.label.add(label_pk)
            return HttpResponse(f"'saved',{form.errors}")
        return HttpResponse(f"'not saved', {form.errors}")


class DisplayAllEmail(LoginRequiredMixin, ListView):
    model = Email


class DisplayDetailEmail(LoginRequiredMixin, DetailView):
    model = Email

    def post(self, request, pk):
        email = Email.objects.get(id=pk)
        email.is_trash = True
        email.save()
        return redirect('/')


class EmailDelete(LoginRequiredMixin, DeleteView):
    model = Email
    success_url = '/'


class UpdateEmail(UpdateView):
    model = Email
    template_name = 'web_page/edite_email.html'
    fields = ['is_trash', 'is_starred', 'is_draft']
    success_url = '/'


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
            return redirect(f'/web_page/email-detail/{pk}')
        return HttpResponse('ok nashod')


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

        email_forwarded = Email(subject=email.subject,
                                text=email.text,
                                sender=forwarder)
        email_forwarded.email_object = email
        email_forwarded.save()
        to_pk = User.objects.get(username=receiver_to).id
        cc_pk = User.objects.get(username=receiver_cc).id
        bcc_pk = User.objects.get(username=receiver_bcc).id
        email_forwarded.receiver_to.add(to_pk)
        email_forwarded.receiver_cc.add(cc_pk)
        email_forwarded.receiver_bcc.add(bcc_pk)

        return HttpResponse('Ok 👌')


# <------ END Email section ------>

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


class ContactList(LoginRequiredMixin, ListView):
    model = ProfileContact


class ContactDetail(LoginRequiredMixin, DetailView):
    model = ProfileContact
    template_name = 'web_page/profilecontact_detail.html'


# <------ END Contact section ------>

# <------ start Label section ------>

class CreateLabel(LoginRequiredMixin, View):

    def get(self, request):
        form = CreateLabelForm()
        return render(request, 'web_page/create_label.html', {"form": form})

    def post(self, request):
        form = CreateLabelForm(request.POST, request.FILES)
        if form.is_valid():
            label_obj = Label(title=form.cleaned_data['title'], )

            label_obj.save()
            return redirect(f'home_inbox')
        return HttpResponse(f"'not saved', {form.errors}")


class LabelList(LoginRequiredMixin, ListView):
    model = Label
    template_name = 'web_page/layout/__leftsidbar.html'


class LabelDetail(LoginRequiredMixin, DetailView):
    model = Label


class LabelDelete(LoginRequiredMixin, DeleteView):
    model = Label
    success_url = '/'


class SearchByLabel(LoginRequiredMixin, View):

    def get(self, request):
        labels = Label.objects.all().values_list('title', flat=True)
        return render(request, 'web_page/search_by_label.html', {'labels': list(labels)})

    def post(self, request):
        label_input = request.POST['search']
        labels = Email.objects.all().filter(label__title__startswith=label_input).values_list('subject', flat=True)
        return render(request, 'web_page/result_search.html', {'labels': labels})


# <------ END Label section ------>

"""
<------ start Categories section ------>

   Sent  Draft Archive Trash
"""


class SentBox(LoginRequiredMixin, View):

    def get(self, request):
        emails = Email.objects.filter(sender=request.user.id)
        return render(request, 'web_page/sentbox.html', {'emails': emails})


class Inbox(LoginRequiredMixin, View):

    def get(self, request):
        emails_to = Email.objects.filter(receiver_to=request.user.id)
        emails_cc = Email.objects.filter(receiver_cc=request.user.id)
        emails_bcc = Email.objects.filter(receiver_bcc=request.user.id)
        return render(request, 'web_page/inbox.html', {'emails_to': emails_to,
                                                       'emails_cc': emails_cc,
                                                       'emails_bcc': emails_bcc})


class Draft(LoginRequiredMixin, View):

    def get(self, request):
        emails_drafted = Email.objects.filter(is_draft=True)
        return render(request, 'web_page/draft.html', {'emails_drafted': emails_drafted})


class Archive(LoginRequiredMixin, View):

    def get(self, request):
        emails_archived = Email.objects.filter(is_starred=True)
        return render(request, 'web_page/archive.html', {'emails_archived': emails_archived})


class Trash(LoginRequiredMixin, View):

    def get(self, request):
        emails_trashed = Email.objects.filter(is_trash=True)
        return render(request, 'web_page/trash.html', {'emails_trashed': emails_trashed})

# <------ END Categories section 😊 ------>

# namayesh File ham Dar email_detail.html line 361 anjam shode

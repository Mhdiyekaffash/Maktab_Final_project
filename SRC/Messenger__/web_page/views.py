from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.views import View
from django.views.generic import ListView, DetailView, DeleteView, UpdateView
from account.models import User
from .forms import CreateEmailForm, ReplyForm, CreateContactForm, CreateLabelForm
from .models import Email, ProfileContact, Label
from django.db.models import Q


#  <----- Email section ----->

class CreateEmail(LoginRequiredMixin, View):

    def get(self, request):
        form = CreateEmailForm()
        id = request.user.id
        contacts = User.objects.get(id=id).contact_user.all().values_list('email', flat=True)
        labels = Label.objects.all().filter(user=request.user.id).values_list('title', flat=True).distinct()
        return render(request, 'web_page/create_email.html', {"form": form,
                                                              'contacts': list(contacts),
                                                              'labels': list(labels)})

    def post(self, request):
        form = CreateEmailForm(request.POST, request.FILES)

        receiver_to = request.POST["to"]  # Taken from the input
        receiver_cc = request.POST["cc"]  # ☝
        receiver_bcc = request.POST["bcc"]  # ☝
        label = request.POST['label']  # ☝

        # The values taken from the input are comma separated and created as a list of recipients
        to_list = receiver_to.split(',')
        cc_list = receiver_cc.split(',')
        bcc_list = receiver_bcc.split(',')

        labels_list = label.split(',')  # for label

        users = User.objects.all().values_list('username', flat=True)
        users_list = [i for i in users]  # List of all users who have an account on the site

        labels_of_user = Label.objects.all().filter(user=request.user)
        labels_of_user_list = [i for i in labels_of_user]

        to_list = [i for i in to_list if i in users_list]  # List of all recipients (to) who have an account on the site
        cc_list = [i for i in cc_list if i in users_list]  # ☝  (cc)
        bcc_list = [i for i in bcc_list if i in users_list]  # ☝  (bcc)

        labels_list = [i for i in labels_list if i in labels_of_user_list]

        # List of id all recipients who have an account on the site 👇
        list_id_to = [User.objects.get(username=i).id for i in to_list]
        list_id_cc = [User.objects.get(username=i).id for i in cc_list]
        list_id_bcc = [User.objects.get(username=i).id for i in bcc_list]

        list_id_label = [Label.objects.get(title=i).id for i in labels_list]

        if form.is_valid():
            user_login = User.objects.get(id=request.user.id)
            email = Email(subject=form.cleaned_data['subject'],
                          text=form.cleaned_data['text'],
                          file=form.cleaned_data['file'],
                          sign=form.cleaned_data['sign'],
                          is_draft=form.cleaned_data['is_draft'],
                          sender=user_login)

            email.save()

            # For when we do not want to send the message and want to stay in the draft file 👇
            if 'draft' in request.POST:

                email.is_draft = True
                email.label.add(*list_id_label)
                email.save()

                return redirect('/web_page/draft/')

            # For when we want to send the message 👇
            else:

                # Recipients are added to the email object one by one based on their ideas 👇
                email.receiver_to.add(*list_id_to)
                email.receiver_cc.add(*list_id_cc)
                email.receiver_bcc.add(*list_id_bcc)

                email.label.add(*list_id_label)

                return redirect('/')
            return HttpResponse(f"'not saved', {form.errors}")


class DisplayAllEmail(LoginRequiredMixin, View):

    def get(self, request):
        emails = Email.objects.all().filter(
            Q(sender=request.user.id) | Q(receiver_to=request.user.id)
            | Q(receiver_cc=request.user.id) | Q(receiver_bcc=request.user.id)).distinct()

        return render(request, 'web_page/email_list.html', {'emails': emails})


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


class AddLabel(View):

    def get(self, request, pk):

        query = Label.objects.filter(user=request.user).values_list('title', flat=True)
        return render(request, 'web_page/add_label_to_email.html', {'query': list(query)})

    def post(self, request, pk):

        print(request.POST)
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

        email_ = Email(subject=email.subject,
                       text=email.text,
                       sender=forwarder)

        email_.save()

        # Recipients are added to the email object one by one based on their ideas 👇
        email_.receiver_to.add(*list_id_to)
        email_.receiver_cc.add(*list_id_cc)
        email_.receiver_bcc.add(*list_id_bcc)

        return redirect('/')


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

   Sent  Draft Archive Trash
"""


class SentBox(LoginRequiredMixin, View):

    def get(self, request):
        emails = Email.objects.filter(sender=request.user.id).distinct()
        return render(request, 'web_page/sentbox.html', {'emails': emails})


class Inbox(LoginRequiredMixin, View):

    def get(self, request):
        emails_to = Email.objects.filter(receiver_to=request.user.id).distinct()
        emails_cc = Email.objects.filter(receiver_cc=request.user.id).distinct()
        emails_bcc = Email.objects.filter(receiver_bcc=request.user.id).distinct()
        return render(request, 'web_page/inbox.html', {'emails_to': emails_to,
                                                       'emails_cc': emails_cc,
                                                       'emails_bcc': emails_bcc})


class Draft(LoginRequiredMixin, View):

    def get(self, request):
        emails_drafted = Email.objects.filter((Q(is_draft=True) & Q(sender=request.user.id)) |
                                              (Q(is_draft=True) & Q(receiver_bcc=request.user.id)) |
                                              (Q(is_draft=True) & Q(receiver_cc=request.user.id)) |
                                              (Q(is_draft=True) & Q(receiver_to=request.user.id))).distinct()

        return render(request, 'web_page/draft.html', {'emails_drafted': emails_drafted})


class Archive(LoginRequiredMixin, View):

    def get(self, request):
        emails_archived = Email.objects.filter((Q(is_starred=True) & Q(sender=request.user.id)) |
                                               (Q(is_starred=True) & Q(receiver_bcc=request.user.id)) |
                                               (Q(is_starred=True) & Q(receiver_cc=request.user.id)) |
                                               (Q(is_starred=True) & Q(receiver_to=request.user.id))).distinct()

        return render(request, 'web_page/archive.html', {'emails_archived': emails_archived})


class Trash(LoginRequiredMixin, View):

    def get(self, request):
        emails_trashed = Email.objects.filter((Q(is_trash=True) & Q(sender=request.user.id)) |
                                              (Q(is_trash=True) & Q(receiver_to=request.user.id)) |
                                              (Q(is_trash=True) & Q(receiver_cc=request.user.id)) |
                                              (Q(is_trash=True) & Q(receiver_bcc=request.user.id))).distinct()

        return render(request, 'web_page/trash.html', {'emails_trashed': emails_trashed})

# <------ END Categories section 😊 ------>

# todo: redirect login be home

from django.urls import path
from .views import *

urlpatterns = [
    path('email-create/', CreateEmail.as_view(), name="email-create"),
    path('email-detail/<int:pk>', DisplayDetailEmail.as_view(), name="email_detail"),
    path('email-replay/<int:pk>', ReplyEmail.as_view(), name="email_replay"),
    path('Forward/<int:pk>', Forward.as_view(), name="email_forward"),
    path('CreateContact/', CreateContact.as_view(), name="CreateContact"),
    path('ContactList/', ContactList.as_view(), name="ContactList"),
    path('contactdetail/<int:pk>', ContactDetail.as_view(), name="ContactDetail"),
    path('deletecontact/<int:pk>', DeleteContact.as_view(), name='delete-contact'),
    path('edite_contact/<int:pk>', UpdateContact.as_view(), name='edite_contact'),
    path('CreateLabel/', CreateLabel.as_view(), name="CreateLabel"),
    path('labe-lList/', LabelList.as_view(), name="LabelList"),
    path('label-Detail/<slug:slug>', LabelDetail.as_view(), name="label-Detail"),
    path('label-Delete/<slug:slug>', LabelDelete.as_view(), name="label-Delete"),
    path('sent-box/', SentBox.as_view(), name="sent-box"),
    path('inbox/', Inbox.as_view(), name="inbox"),
    path('draft/', Draft.as_view(), name="draft"),
    path('archive/', Archive.as_view(), name="archive"),
    path('trash/', Trash.as_view(), name="trash"),
    path('emaildelete/<int:pk>', EmailDelete.as_view(), name="email_delete"),
    path('edit_email/<int:pk>', UpdateEmail.as_view(), name='edit_email'),
    path('search-byLabel/', SearchByLabel.as_view(), name='search-byLabel'),
    path('add-label/<int:pk>', AddLabel.as_view(), name='addlabel'),
    path('send-from-draft/<int:pk>', SendDraft.as_view(), name="send-from-draft"),
    # path('not_archive/<int:pk>', Not_Archive.as_view(), name='not_archive'),
]

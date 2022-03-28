from django.urls import path
from .views import *

urlpatterns = [
    # Email section
    path('email-create/', CreateEmail.as_view(), name="email-create"),
    path('email-detail/<int:pk>', DisplayDetailEmail.as_view(), name="email_detail"),
    path('emaildelete/<int:pk>', EmailDelete.as_view(), name="email_delete"),

    path('email-replay/<int:pk>', ReplyEmail.as_view(), name="email_replay"),
    path('Forward/<int:pk>', Forward.as_view(), name="email_forward"),

    path('search_email/', search_content_email, name="search_email"),  # search by ajax

    path('filter-email/', FilterEmail.as_view(), name="filter-email"),

    path('api/emails/', EmailsList.as_view(), name='emails-list'),  # Emails List for any User

    # Contact section
    path('CreateContact/', CreateContact.as_view(), name="CreateContact"),
    path('ContactList/', ContactList.as_view(), name="ContactList"),
    path('contactdetail/<int:pk>', ContactDetail.as_view(), name="ContactDetail"),
    path('deletecontact/<int:pk>', DeleteContact.as_view(), name='delete-contact'),
    path('edite_contact/<int:pk>', UpdateContact.as_view(), name='edite_contact'),
    path('contact_csv/', exportcsv, name='contact_csv'),
    path('search-contacts/', SearchContacts.as_view(), name='search-contacts'),

    path('search_contact/', search_content_contact, name="search_contact"),  # search by ajax
    path('api/contacts/', ContactsList.as_view(), name='contacts-list'),  # Contacts List for any User

    # Label section
    path('CreateLabel/', CreateLabel.as_view(), name="CreateLabel"),
    path('labe-lList/', LabelList.as_view(), name="LabelList"),
    path('label-Detail/<slug:slug>', LabelDetail.as_view(), name="label-Detail"),
    path('label-Delete/<slug:slug>', LabelDelete.as_view(), name="label-Delete"),
    path('search-byLabel/', SearchByLabel.as_view(), name='search-byLabel'),
    path('add-label/<int:pk>', AddLabel.as_view(), name='addlabel'),

    # Categories
    path('sent-box/', SentBox.as_view(), name="sent-box"),
    path('inbox/', Inbox.as_view(), name="inbox"),
    path('draft/', Draft.as_view(), name="draft"),
    path('archive/', Archive.as_view(), name="archive"),
    path('check-archive/<int:pk>', check_archive, name="check-archive"),

    path('check-trash/<int:pk>', check_trash, name="check-trash"),
    path('trash/', Trash.as_view(), name="trash"),
    path('send-from-draft/<int:pk>', SendDraft.as_view(), name="send-from-draft"),

    # Signature section
    path('create-signature/', CreateSignature.as_view(), name='create-signature'),
    path('signature-detail/<int:pk>', SignatureDetail.as_view(), name='signature-detail'),
    path('signatures/', SignatureList.as_view(), name='signatures'),

    path('search_email/', search_content_email, name="search_email"),
]

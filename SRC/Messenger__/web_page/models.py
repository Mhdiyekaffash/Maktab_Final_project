from django.db import models
from django.urls import reverse
from account.models import User
from .validators import validate_file_size


class Label(models.Model):
    title = models.CharField(max_length=20, null=False)
    slug = models.SlugField(max_length=20, unique=True, null=True)

    def __str__(self):
        return self.title


class ProfileContact(models.Model):
    first_name = models.CharField(max_length=30, null=False)
    last_name = models.CharField(max_length=30, null=False)
    email = models.EmailField(null=False)
    profile_photo = models.ImageField(upload_to='media', null=True, blank=True)
    phone_number = models.CharField(max_length=11, null=True, blank=True)
    birthday = models.DateField(null=True, blank=True)
    slug = models.SlugField(max_length=20, unique=True, null=True)
    owner = models.ForeignKey(User, related_name='contact_user', on_delete=models.CASCADE, null=True)

    class Meta():
        verbose_name = ""
        unique_together = [('owner', 'email')]

    def __str__(self):
        return self.last_name


class Signature(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_DEFAULT, default='deleted')
    # category = models.ForeignKey(SignatureCategory, on_delete=models.CASCADE)  # ont to many
    text = models.CharField(max_length=20, null=False)
    photo = models.ImageField(upload_to='media', null=True, blank=True)
    # This photo can be used as a stamp for a signature


class Email(models.Model):
    subject = models.CharField(max_length=100, null=True)
    text = models.TextField(max_length=1000, null=True)
    file = models.FileField(upload_to='Files', null=True, blank=True, validators=[validate_file_size])
    created = models.DateTimeField(auto_now_add=True)
    edited = models.DateTimeField(auto_now=True)
    receiver = models.ManyToManyField(ProfileContact, related_name='receivers')
    label = models.ManyToManyField(Label, related_name='labels')
    slug = models.SlugField(max_length=20, unique=True, null=True)
    is_sent = models.BooleanField(default=False)
    is_inbox = models.BooleanField(default=False)
    is_starred = models.BooleanField(default=False)
    is_draft = models.BooleanField(default=False)
    is_trash = models.BooleanField(default=False)
    is_read = models.BooleanField(default=False)
    sign = models.ForeignKey(Signature, on_delete=models.SET_NULL, null=True)
    sender = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='sender', blank=True)

    def get_absolute_url(self):
        return reverse("account:home")

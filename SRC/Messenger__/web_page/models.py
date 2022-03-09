from django.db import models
from account.models import User
from .validators import validate_file_size
from django.utils.text import slugify


class Label(models.Model):
    title = models.CharField(max_length=20, null=False)
    slug = models.SlugField(max_length=20, unique=True, null=True)
    user = models.ForeignKey(User, related_name='label_user', on_delete=models.CASCADE, null=True, blank=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title)

        super().save(*args, **kwargs)

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
    other_email = models.EmailField(null=True, blank=True)
    user = models.ForeignKey(User, related_name='contact_user', on_delete=models.CASCADE, null=True)

    class Meta():
        unique_together = [('user', 'email')]

    def __str__(self):
        return self.last_name


class Signature(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    text = models.CharField(max_length=20, null=False)
    photo = models.ImageField(upload_to='media', null=True, blank=True)
    # This photo can be used as a stamp for a signature


class Email(models.Model):
    subject = models.CharField(max_length=100, null=True, blank=True)
    text = models.TextField(max_length=1000, null=True, blank=True)
    file = models.FileField(upload_to='Files', null=True, blank=True, validators=[validate_file_size])
    created = models.DateTimeField(auto_now_add=True)
    edited = models.DateTimeField(auto_now=True)
    receiver_to = models.ManyToManyField(User, related_name='receivers_to')
    receiver_cc = models.ManyToManyField(User, related_name='receivers_cc', null=True, blank=True)
    receiver_bcc = models.ManyToManyField(User, related_name='receivers_bcc', null=True, blank=True)
    label = models.ManyToManyField(Label, related_name='labels', blank=True)
    slug = models.SlugField(max_length=20, unique=True, null=True)
    is_starred = models.BooleanField(default=False)
    is_draft = models.BooleanField(default=False)
    is_trash = models.BooleanField(default=False)
    is_read = models.BooleanField(default=False)
    email_obj = models.ForeignKey('self', on_delete=models.SET_NULL, null=True, blank=True)
    # az in field baraye replay estefade mishavad ☝
    sign = models.ForeignKey(Signature, on_delete=models.SET_NULL, null=True, blank=True)
    sender = models.ForeignKey(User, on_delete=models.PROTECT, null=True, related_name='sender', blank=True)

    # if user ya reciver hazf shodan email hazf nashvad va etelate marboot be user baraye emeil hefz shavad
    # if sign ya lable hazf shavad fild marboote null shavad

    def __str__(self):
        return self.text

from django.db import models
from account.models import User
from .validators import validate_file_size
from django.utils.text import slugify
from ckeditor.fields import RichTextField


class Label(models.Model):
    title = models.CharField(max_length=20, null=False)
    slug = models.SlugField(max_length=20, null=True)
    user = models.ForeignKey(User, related_name='label_user', on_delete=models.CASCADE, null=True, blank=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title + self.user.username)

        super().save(*args, **kwargs)

    def __str__(self):
        return self.title


class Filter(models.Model):
    filter_by = models.CharField(max_length=100)
    label = models.ForeignKey(Label, on_delete=models.CASCADE, null=True, blank=True)
    owner = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return f'{self.filter_by} + {self.owner}'


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

    def __str__(self):
        return self.text


class Email(models.Model):
    subject = models.CharField(max_length=100, null=True, blank=True)
    text = RichTextField(blank=True, null=True)
    file = models.FileField(upload_to='Files', null=True, blank=True, validators=[validate_file_size])
    created = models.DateTimeField(auto_now_add=True)
    edited = models.DateTimeField(auto_now=True)
    receiver_to = models.ManyToManyField(User, related_name='receivers_to')
    receiver_cc = models.ManyToManyField(User, related_name='receivers_cc', null=True, blank=True)
    receiver_bcc = models.ManyToManyField(User, related_name='receivers_bcc', null=True, blank=True)
    label = models.ManyToManyField(Label, related_name='labels', blank=True)
    slug = models.SlugField(max_length=20, unique=True, null=True)
    # is_read = models.BooleanField(default=False)
    email_obj = models.ForeignKey('self', on_delete=models.SET_NULL, null=True, blank=True)
    # This field is used for replay ???
    sign = models.ForeignKey(Signature, on_delete=models.SET_NULL, null=True, blank=True)
    sender = models.ForeignKey(User, on_delete=models.PROTECT, null=True, related_name='sender', blank=True)
    filter = models.ManyToManyField(Filter, related_name='filters', blank=True)

    @property
    def file_size(self):
        if self.file and hasattr(self.file, 'size'):
            return self.file.size

    def __str__(self):
        return str(self.subject)


class EmailFolder(models.Model):
    email = models.ForeignKey(Email, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    is_trash = models.BooleanField(default=False)
    is_archive = models.BooleanField(default=False)
    is_draft = models.BooleanField(default=False)

    def __str__(self):
        return str(self.email)

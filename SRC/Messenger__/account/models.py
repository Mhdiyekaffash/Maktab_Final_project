from django.db import models
from django.contrib.auth.models import AbstractUser
from account.manager import UserManager
from account.validators import validate_phone_no, validate_length_phone_no


class User(AbstractUser):
    # email_confirmed = models.BooleanField(default=False)
    email = models.EmailField(null=True, blank=True, verbose_name='Email Recovery')
    phone_number = models.CharField(max_length=11, null=True, blank=True, validators=[validate_phone_no, validate_length_phone_no])
    birthday = models.DateField(null=True, blank=True)

    type_choices_gender = [
        ('F', 'female'),
        ('M', 'male'),
        ('C', 'Custom'),
        ('R', 'Rather not say')
    ]

    gender_type = models.CharField(max_length=1, choices=type_choices_gender, null=True, blank=True)
    type_choices_country = [
        ('ir', 'Iran'),
        ('FR', 'France'),
        ('UK', 'United Kingdom'),
        ('US', 'United States'),
    ]

    country_type = models.CharField(max_length=2, choices=type_choices_country, null=True, blank=True)
    slug = models.SlugField(max_length=100, unique=True, null=True)

    def __str__(self):
        return self.username

    objects = UserManager()

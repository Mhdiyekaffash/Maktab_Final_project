from django import template
from web_page.models import Email
from account.models import User

register = template.Library()


@register.simple_tag(name='my_receiver')
def my_receiver():
    # list_to = []
    # for r in Email.objects.receiver_to.values_list():
    #     list_to.append(r)

    return list(Email.receiver_to)


from rest_framework import serializers
from .models import *


class ContactSerializer(serializers.ModelSerializer):
    user = serializers.ReadOnlyField(source='user.username')

    class Meta:
        model = ProfileContact
        fields = "__all__"


class EmailSerializer(serializers.ModelSerializer):

    sender = serializers.StringRelatedField(required=False, read_only=True)

    receiver_to = serializers.StringRelatedField(many=True)
    receiver_cc = serializers.StringRelatedField(many=True)
    receiver_bcc = serializers.StringRelatedField(many=True)

    label = serializers.StringRelatedField(many=True)
    sign = serializers.StringRelatedField()

    class Meta:
        model = Email
        fields = "__all__"

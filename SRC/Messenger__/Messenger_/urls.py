"""Messenger_ URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from account.views import Login, PasswordChange
from django.urls import path, include
from account.views import Register, ActivateAccount
from web_page.views import DisplayAllEmail
from rest_framework.authtoken.views import obtain_auth_token

urlpatterns = [
    # path('', include('account.urls')),
    path('', DisplayAllEmail.as_view(), name='home'),
    path('admin/', admin.site.urls),
    path('', include('django.contrib.auth.urls')),
    path('login/', Login.as_view(), name='login'),
    path('password_change/', PasswordChange.as_view(), name='password_change'),
    path('account/', include('account.urls')),
    path('web_page/', include('web_page.urls')),
    path('signup/', Register.as_view(), name='register'),
    path('activate/<uidb64>/<token>/', ActivateAccount.as_view(), name='activate'),
    path('api-token-auth/', obtain_auth_token),
]

from django.conf import settings
from django.conf.urls.static import static

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

from django.urls import path, re_path
from . import views
from rest_framework_jwt.views import obtain_jwt_token

urlpatterns = [
    # path("login/", obtain_jwt_token),
    path("login/", views.LoginAPIView.as_view(), name="login"),
    re_path("^mobile/(?P<mobile>1[3-9]\d{9})/$", views.MobileAPIView.as_view()),
    path("register/", views.UserAPIView.as_view()),
    re_path("^sms/(?P<mobile>1[3-9]\d{9})$", views.SMSAPIView.as_view())
]
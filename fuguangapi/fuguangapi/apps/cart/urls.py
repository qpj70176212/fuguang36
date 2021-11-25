from django.urls import path
from . import views

urlpatterns = [
    path("", views.CartViewSet.as_view({
        "post": "add_cart",
        "get": "list",
    })),
]
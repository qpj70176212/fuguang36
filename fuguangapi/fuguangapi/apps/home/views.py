import constants
# from rest_framework.generics import ListAPIView
from .models import Nav, Banner
from .serializers import NavModelSerializer, BannerModelSerializer
from views import ListAPIView


class HeaderNavListAPIView(ListAPIView):
    """
    头部导航
    """

    queryset = Nav.objects.filter(is_delete=False, is_show=True,
                                  position=constants.NAV_HEADER
                                  ).order_by("orders", "-id")[:constants.NAV_HEADER_SIZE]
    serializer_class = NavModelSerializer


class FooterNavListAPIView(ListAPIView):
    """
    脚部导航
    """
    queryset = Nav.objects.filter(is_delete=False, is_show=True,
                                  position=constants.NAV_FOOTER
                                  ).order_by("orders", "-id")[:constants.NAV_FOOTER_SIZE]
    serializer_class = NavModelSerializer


class BannerListAPIView(ListAPIView):
    """轮播广告列表"""
    queryset = Banner.objects.filter(is_delete=False, is_show=True).order_by(
        "orders", "-id").all()[:constants.BANNER_SIZE]
    serializer_class = BannerModelSerializer

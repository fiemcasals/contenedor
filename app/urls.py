
from django.contrib import admin
from django.urls import path
from .view import BienvenidoView, TipificacionView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', BienvenidoView.as_view(), name='bienvenido'),
    path('tipificacion', TipificacionView.as_view(), name='tipificacion'),
]


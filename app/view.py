from django.views.generic import TemplateView


class BienvenidoView(TemplateView):
    template_name = "bienvenido.html"
    
class TipificacionView(TemplateView):
    template_name = "tipificacion.html"
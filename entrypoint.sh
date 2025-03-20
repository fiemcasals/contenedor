#!/bin/sh

echo "Esperando a que la base de datos esté lista..."
while ! mysqladmin ping -h"db" --silent; do
    sleep 2
done

echo "Aplicando migraciones..."
python manage.py migrate

echo "Creando superusuario si no existe..."
echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(is_superuser=True).exists() or User.objects.create_superuser('admin', 'admin@example.com', 'adminpass')" | python manage.py shell

echo "Recolectando archivos estáticos..."#se hacen los estaticos para sacarlo a produccion<-preguntar
python manage.py collectstatic --noinput

echo "Iniciando servidor de Django..."#se esta ejecutando dos veces, una en el dockerfile y otra aca...
python manage.py runserver 0.0.0.0:8000


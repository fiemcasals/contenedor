FROM python:3.11.11-alpine3.20

# Configuración de entorno
ENV PYTHONUNBUFFERED=1

# Definir el directorio de trabajo
WORKDIR /app

# Actualizar repositorios y agregar dependencias necesarias
RUN apk update && apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    jpeg-dev \
    zlib-dev \
    mariadb-dev \
    mariadb-connector-c-dev \
    build-base \
    linux-headers \
    pkgconfig \
    mysql-client  # Ya estaba al final, lo incluimos aquí

# Instalar y actualizar pip
RUN pip install --upgrade pip

# Crear un entorno virtual dentro del contenedor
RUN python -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Copiar dependencias primero para aprovechar el cache de Docker
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código de la aplicación
COPY . /app/

# Dar permisos al entrypoint
RUN chmod +x /app/entrypoint.sh

# Definir el comando de inicio
ENTRYPOINT ["sh", "/app/entrypoint.sh"]

# Ejecutar el servidor de Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


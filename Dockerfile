FROM python:3.11.11-alpine3.20

# Configuración de entorno
ENV PYTHONUNBUFFERED=1

# Configuración del directorio de trabajo
WORKDIR /app

# Actualizar repositorios y agregar dependencias necesarias
RUN apk update \
    && apk add --no-cache \
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
    && pip install --upgrade pip


# Definir el entorno virtual como el intérprete por defecto de Python
ENV PATH="/venv/bin:$PATH"

# Copiar el código de la aplicación
COPY ./ ./

# Otorgar permisos de ejecución al entrypoint
RUN chmod +x /app/entrypoint.sh

# Definir el comando de inicio
ENTRYPOINT ["sh", "/app/entrypoint.sh"]

# Copiar el código del proyecto
WORKDIR /app

# Crear un entorno virtual dentro del contenedor
RUN python -m venv /venv

# Definir el entorno virtual como el intérprete por defecto de Python
ENV PATH="/venv/bin:$PATH"

# Instalar dependencias dentro del entorno virtual
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente del proyecto
COPY . /app

# Ejecutar el servidor de Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

RUN apk add --no-cache mysql-client


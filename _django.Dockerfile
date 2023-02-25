# escape=\
FROM python:3.9.16-slim-bullseye

# create django user and group
RUN addgroup --system --gid 101 django \
    && adduser --system --disabled-login --ingroup django --home /home/django --gecos "django user" --shell /bin/false --uid 101 django

# Create the application directory and access it
WORKDIR /home/django

# Copy requirements.txt file to image
COPY ["requirements.txt", "."]

# Copy app folder to image
COPY ["docker_django/", "docker_django/"]

# Install gunicorn and app's requirements 
RUN pip install -r ./requirements.txt \
	&& python -m pip cache purge \
	&& mkdir /var/run/gunicorn/ \
	&& chown -R django:django /var/run/gunicorn \
	&& chown -R django:django /home/django

WORKDIR /home/django/docker_django

ENV USE_CONTAINER_DB=False
# [ docker compose or swarm mode ] True => Use 'database' service
# [ single container ] False => Use SQLite 
# 		-> This environment variable is overwrite to TRUE by default when running docker-compose.yml file

EXPOSE 8000

USER django

ENTRYPOINT [ "/bin/bash", "django_entrypoint.sh" ]
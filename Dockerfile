# pull official base image
FROM python:3.9.6-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add --no-cache gcc musl-dev \
    mariadb-dev

# install dependencies
RUN pip install --upgrade pip
COPY app/requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY  app .

EXPOSE 8000

ENTRYPOINT ["python", "manage.py", "runserver", "0.0.0.0:8000"]
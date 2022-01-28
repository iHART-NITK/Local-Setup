#!/bin/bash

echo "make migrations"
python ihart_backend/manage.py makemigrations

echo "migrate"
python ihart_backend/manage.py migrate

echo "Starting server"
python ihart_backend/manage.py runserver 0.0.0.0:8000

from .base_settings import *
import os

if os.environ.get('DEBUG'):
  DEBUG =True
else:
  DEBUG =False
  

ALLOWED_HOSTS = [os.environ.get('ALLOWED_HOST', '*')]

DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.mysql',
    'NAME': os.environ.get('MYSQL_DATABASE','todobackend'),
    'USER': os.environ.get('MYSQL_USER', 'todo'),
    'PASSWORD': os.environ.get('MYSQL_PASSWORD', 'password'),
    'HOST': os.environ.get('MYSQL_HOST', 'localhost'),
    'PORT': os.environ.get('MYSQL_PORT', '3306')
  }
}

STATIC_ROOT = os.environ.get('STATIC_ROOT', '/var/www/todobackend/static')
STATIC_MEDIA = os.environ.get('STATIC_MEDIA', '/var/www/todobackend/media')


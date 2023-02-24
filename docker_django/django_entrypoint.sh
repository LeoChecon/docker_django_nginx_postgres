echo ' - - > making migrations...' &&
python manage.py makemigrations &&
echo ' - - > migrating...' &&
python manage.py migrate &&
echo ' - - > starting Gunicorn server...' &&
gunicorn -c gunicorn.conf.py
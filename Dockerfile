# Use the official Python image as the base
FROM python:3.9-slim
# Copy the project files into the container
COPY . .
# Install required system packages
RUN apt-get update && apt-get install -y python3-distutils && apt-get clean

# Install project dependencies
RUN pip install --no-cache-dir django==3.2

# Run the commands to collect static files and make migrations
RUN python manage.py collectstatic --noinput
RUN python manage.py makemigrations
RUN python manage.py migrate

# Expose the application port
EXPOSE 8000
# Run the Django development server
CMD ["python","manage.py","runserver","0.0.0.0:8000"] 


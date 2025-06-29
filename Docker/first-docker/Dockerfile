FROM ubuntu:latest

# Update package list and install Apache
RUN apt update && apt install -y apache2

# Copy website content
COPY index.html /var/www/html/

# Expose port 80 for HTTP
EXPOSE 8090

# Start Apache in foreground
CMD ["apachectl", "-D", "FOREGROUND"]


# docker build -t my-apache .
# docker run -d -p 80:80 my-apache

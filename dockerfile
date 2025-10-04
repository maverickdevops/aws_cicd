# Use the official Apache HTTPD base image
FROM httpd:2.4

# Copy your static website files into the container
# (optional if you just want a default page)
COPY ./public-html/ /usr/local/apache2/htdocs/

# Expose port 80
EXPOSE 80

# The httpd image already has the default CMD to start Apache

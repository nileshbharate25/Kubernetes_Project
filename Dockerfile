FROM ubuntu:latest
MAINTAINER nilesh@gmail.com

# Update package list and install dependencies, including AWS CLI
RUN apt-get update \
    && apt-get install -y zip unzip apache2 \
    && apt-get install -y awscli

# Copy the file from the S3 bucket to the container's /var/www/html/ directory
RUN aws s3 cp s3://mys3-02/s3-upload/photogenic.zip /var/www/html/

# Unzip the file and clean up
WORKDIR /var/www/html/
RUN unzip photogenic.zip \
    && cp -rvf photogenic/* . \
    && rm -rf photogenic photogenic.zip

# Start Apache server
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

# Expose ports
EXPOSE 80

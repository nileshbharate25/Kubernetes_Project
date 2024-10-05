FROM centos
MAINTAINER nilesh@gmail.com

# Install dependencies, including AWS CLI
RUN yum -y install zip unzip httpd \
    && yum install -y awscli

# Copy the file from the S3 bucket to the container's /var/www/html/ directory
RUN aws s3 cp s3://mys3-02/s3-upload/photogenic.zip /var/www/html/

# Unzip the file and clean up
WORKDIR /var/www/html/
RUN unzip photogenic.zip \
    && cp -rvf photogenic/* . \
    && rm -rf photogenic photogenic.zip

# Start Apache server
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose ports
EXPOSE 80

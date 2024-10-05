FROM centos

MAINTAINER vikash@gmail.com

# Update YUM repo configurations and install necessary packages
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum clean all && \
    yum -y install java httpd zip unzip && \
    yum clean all

# Download and extract the template to the correct directory
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip -q photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Start Apache HTTPD in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Expose ports 80 (HTTP) and 22 (SSH)
EXPOSE 80 22

FROM debian:stable

MAINTAINER Stefan Ritter <mail@stefanritter.net>

# Install needed packages
RUN apt update
RUN apt install -y wget mysql-common
RUN apt-get install -y libmariadb-dev

# Create directories
RUN mkdir /sphereserver

# Binary is linked to libmysqlclient.so.20
RUN wget http://security.ubuntu.com/ubuntu/pool/main/m/mysql-5.7/libmysqlclient20_5.7.42-0ubuntu0.18.04.1_amd64.deb
RUN dpkg -I libmysqlclient20_5.7.42-0ubuntu0.18.04.1_amd64.deb

# Get sphere
RUN wget https://forum.spherecommunity.net/sshare.php?downproj=64 -O sphereserver.tar.gz
RUN tar xf sphereserver.tar.gz -C /sphereserver
RUN cp /sphereserver/build-64/bin-x86_64/SphereSvrX64_nightly /sphereserver/spheresvr

# Cleanup
RUN rm sphereserver.tar.gz libmysqlclient20_5.7.42-0ubuntu0.18.04.1_amd64.deb

# Port
EXPOSE 2593

# Run
WORKDIR /sphereserver
CMD ["./spheresvr"]

FROM ubuntu:latest

# Environment for Bamboo
ENV BAMBOO_VERSION 5.14.4.1
ENV BAMBOO_HOME /home/bamboo

# Expose ports (web/agent)
EXPOSE 8085
EXPOSE 54663

ADD bamboo-server.sh /usr/local/bin/bamboo-server.sh

RUN echo "deb http://archive.ubuntu.com/ubuntu xenial main universe restricted multiverse" > /etc/apt/sources.list && \
  apt-get update && \
  apt-get install  --no-install-recommends --no-install-suggests -yq software-properties-common python-software-properties && \
  add-apt-repository ppa:webupd8team/java && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
  apt-get update && apt-get upgrade && \
  apt-get install  --no-install-recommends --no-install-suggests -yq oracle-java8-installer && \
  apt-get install  --no-install-recommends --no-install-suggests -yq oracle-java8-set-default git subversion maven gradle && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  chmod +x /usr/local/bin/bamboo-server.sh

CMD ["/usr/local/bin/bamboo-server.sh"]
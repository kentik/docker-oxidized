FROM debian:stretch
MAINTAINER Costas Drogos <costas.drogos@gmail.com>

ENV TZ=UTC
ENV DEBIAN_FRONTEND=noninteractive

RUN	apt-get update && \
	apt-get -yq dist-upgrade && \
	apt-get -yq install --no-install-recommends \
        ruby2.3 \
        ruby-dev \
        libsqlite3-dev \
        libssl-dev \
        pkg-config \
        make \
        cmake \
        libssh2-1-dev \
        git \
        g++ \
        busybox-syslogd \
        procps \
        vim \
        ssh-client \
		supervisor 

RUN useradd oxidized -d /home/oxidized -M -r && \
	git clone https://github.com/costasd/oxidized.git /home/oxidized/oxidized && \
	chown -R oxidized:oxidized /home/oxidized

RUN cd /home/oxidized/oxidized && \
    gem build oxidized.gemspec && \
    gem install --no-ri --no-rdoc oxidized-*.gem && \
    gem install --no-ri --no-rdoc oxidized-web && \
    gem install --no-ri --no-rdoc aws-sdk && \
    gem install --no-ri --no-rdoc slack-api && \
    gem install --no-ri --no-rdoc xmpp4r

RUN apt-get remove -y ruby-dev pkg-config make cmake
RUN	apt-get -yq autoremove --purge && \
	apt-get clean && \
	rm -rf /var/lib/mysql /var/run/mysql/* && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY files/docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh
CMD ["/usr/local/bin/docker-entrypoint.sh"]

FROM jwilder/nginx-proxy:0.2.0

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -fy -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
RUN apt-get install --no-install-recommends -y git cron vim \
 python python-dev virtualenv python-virtualenv gcc dialog libaugeas0 augeas-lenses \ 
 libssl-dev libffi-dev ca-certificates \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN systemctl enable cron
RUN cd / && git clone https://github.com/letsencrypt/letsencrypt


ENV DOCKER_GEN_VERSION 0.7.0

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz



COPY etc /etc
COPY ssl.tmpl /app/
COPY createSSL.sh /
RUN chmod +x /createSSL.sh
COPY Procfile /app/Procfile
COPY cronfile /app/cronfile
RUN crontab /app/cronfile

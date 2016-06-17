FROM jwilder/nginx-proxy:0.4.0

ENV DEBIAN_FRONTEND=noninteractive
ENV YES_FLAG=-y
RUN apt-get update
RUN apt-get -fy -o Dpkg::Options::="--force-confnew" --force-yes -fuy dist-upgrade
RUN apt-get install --no-install-recommends -y git cron vim 
RUN systemctl enable cron

RUN cd / && mkdir certbot && cd certbot && wget https://dl.eff.org/certbot-auto && chmod a+x ./certbot-auto
RUN /certbot/certbot-auto certonly || exit 0
#RUN rm -rf /etc/certbot/accounts/

#RUN cd / && git clone https://github.com/letsencrypt/letsencrypt
#RUN /letsencrypt/letsencrypt-auto certonly || exit 0
RUN rm -rf /etc/letsencrypt/accounts/
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV DOCKER_GEN_VERSION 0.7.3

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

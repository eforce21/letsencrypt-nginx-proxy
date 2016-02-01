FROM jwilder/nginx-proxy:0.2.0

RUN apt-get update && apt-get install -y git cron vim && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN systemctl enable cron
RUN cd / && git clone https://github.com/letsencrypt/letsencrypt

COPY etc /etc
COPY ssl.tmpl /app/
COPY createSSL.sh /
RUN chmod +x /createSSL.sh
COPY Procfile /app/Procfile
COPY cronfile /app/cronfile
RUN crontab /app/cronfile

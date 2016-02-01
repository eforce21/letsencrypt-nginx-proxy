FROM jwilder/nginx-proxy

RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN cd / && git clone https://github.com/letsencrypt/letsencrypt

RUN mkdir -p /etc/letsencrypt/accounts
COPY accounts /etc/letsencrypt/accounts
COPY etc /etc
COPY ssl.tmpl /app
COPY createSSL.sh /
RUN chmod +x /createSSL.sh
COPY Procfile /app/Procfile

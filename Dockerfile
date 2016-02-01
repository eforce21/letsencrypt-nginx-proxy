FROM jwilder/nginx-proxy

RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN cd / && git clone https://github.com/letsencrypt/letsencrypt

COPY etc /etc
COPY ssl.tmpl /app
COPY createSSL.sh /
RUN chmod +x /createSSL.sh
COPY Procfile /app/Procfile

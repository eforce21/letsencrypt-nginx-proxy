nginx: nginx
confgen: docker-gen -notify-output -watch -only-exposed -notify "nginx -s reload" /app/nginx.tmpl /etc/nginx/conf.d/default.conf
sslgen: docker-gen -notify-output -watch -only-exposed -notify "/createSSL.sh" /app/ssl.tmpl /createSSL.sh
cron: /usr/sbin/cron -f 

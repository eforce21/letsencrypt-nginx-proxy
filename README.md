# letsencrypt-nginx-proxy
letsencrypt-nginx-proxy is based on [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/). It sets up a container running nginx and [docker-gen](https://github.com/jwilder/docker-gen).
See [Automated Nginx Reverse Proxy for Docker](http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/) for why you might want to use this.
In addition tothe functionality that [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/ ) offers (reverse proxy configs for nginx and reloads nginx when containers are started and stopped) we use with docker-gen to generate a SSL certificate from letsencrypt to secure the domain.

### Usage
If you want to run it without SSL support, please have a look at the page for the  [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/). That's what you're actually looking for.

To run it:

    $ docker-compose up -d

That's about it already.

### Configuration
If there's anything else you want to configure. Please also have a look at [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/). There you'll find more beautiful documentation on how to do more magic with this reverse proxy.

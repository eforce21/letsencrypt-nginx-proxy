# letsencrypt-nginx-proxy
letsencrypt-nginx-proxy is based on [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/). It sets up a container running nginx and [docker-gen](https://github.com/jwilder/docker-gen).
See [Automated Nginx Reverse Proxy for Docker](http://jasonwilder.com/blog/2014/03/25/automated-nginx-reverse-proxy-for-docker/) for why you might want to use this.
In addition to the functionality that [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/) offers (reverse proxy configs for nginx and reloads nginx when containers are started and stopped) we use docker-gen to generate a SSL certificate from letsencrypt to secure the domain.

### Usage
If you want to run it without SSL support, please have a look at the page for the  [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/). That's what you're actually looking for.

To run it:

    $ docker-compose up -d

That's about it already. If you want to run it without `docker-compose` it would like this:
    $ docker run -d --name nginx-proxy -v /var/run/docker.sock:/tmp/docker.sock:ro -e LETSENCRYPT_EMAIL=<your_email@domain.de> --restart=always eforce21/letsencrypt-nginx-proxy

### Configuration
You can configure the email address that should be used for certificate generation with letsencrypt with the environment variable `LETSENCRYPT_EMAIL`. If you do not set it, the email address will defaul to `info@vHost`.

If there's anything else you want to configure. Please also have a look at [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy/). There you'll find more beautiful documentation on how to do more magic with this reverse proxy.

### How does it work?
We use [Let's Encrypt](https://letsencrypt.org/) to generate the SSL certificates. Those certificates are free and expire every 3 months.
We use [docker-gen](https://github.com/jwilder/docker-gen) to watch for starting containers and generate a shell-script that will run [Let's Encrypt](https://letsencrypt.org/). This will give you a SSL certificate in a matter of a couple of seconds. (So please don't worry when the certificate won't show up right after you start the container for the first time!). We use the `--keep-until-expiring` flag so you hopefully don't run into [beta restrictions](https://community.letsencrypt.org/t/public-beta-rate-limits/4772). That means the certificate will be renewed if it expires in 10 or less days automatically on container (re)start.
Additional we have `cron` installed in the container to check regularly that your SSL certificates don't expire as you might not (re)start your containers every 3 months. That check will be performed at 10am. If you want to change that, just change it in the `cronfile`.
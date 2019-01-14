# SSL Reverse Proxy with certbot 🐋
A general purpose SSL reverse proxy with optional Let's Encrypt certificate generation and renewal. Built on top of Nginx.
## Environment
* SRP_PROXY_URL: defines the address for the proxy server (e.g. example.org, no need to include the protocol)
* SRP_DOWNSTREAM_URL: defines the address for the actual resource server (e.g. example.org:8080, no need to include the protocol)
## Custom Certificate
By default, this image will generate a Let's Encrypt certificate that will be tried to be renewed every week. If you want to omit this behavior and use a custom certificate, you can do so by mounting a certificate at `/etc/letsencrypt/live/$SRP_PROXY_URL/fullchain.pem` with the corresponding private key at `/etc/letsencrypt/live/$SRP_PROXY_URL/privkey.pem` 
## Usage with Docker Compose
If you want to use this image to hide your non-SSL image behind a proxy, you can do so by creating a Docker link e.g.:
```
wordpress:
    image: wordpress:latest
ssl-reverse-proxy:
    image: diwangs/ssl-reverse-proxy
    links:
        - wordpress:$SRP_DOWNSTREAM_URL
```
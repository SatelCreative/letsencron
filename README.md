# letsencron
Simple certbot modified image to renew domains with letsencrypt every month

## Add new domain

After you enabled the ACME challenge support for your server
(e.g. [for nginx](https://community.letsencrypt.org/t/how-to-nginx-configuration-to-enable-acme-challenge-support-on-all-http-virtual-hosts/5622)
and your letsencron image is running under the service name letsencryt
simply run (if using docker-compose)
```
docker-compose exec letsencrypt add_domain www.example.com
```

## Renewal

The renewal command is called hourly and randomly as suggested
[on the official documentation](https://certbot.eff.org/lets-encrypt/pip-other.html)

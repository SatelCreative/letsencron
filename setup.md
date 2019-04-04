### Note: This documentation guides you through setting up new letsencron service and renew website certificate. 

## This section is for a brand new setup. 
1. Prepare for _docker-compose.yml_ file. 

Example:
```
version: '3.5'

services:
    letsencrypt:
        image: satel/letsencron:1.1
        volumes:
            - /home/satel/nginx/conf.d:/nginx
            - /home/satel/data/certs:/etc/letsencrypt
            - /home/satel/data/certs-data:/data/letsencrypt
networks:
    default:
        name: hub_network
        external: true
```

__version__: Please see docker documentation for updated versioning  (https://docs.docker.com/compose/compose-file/compose-versioning/).

__volumes__: Needs to be modified to reflect the correct paths for __nginx__, __certs__ and __certs-data__.

__networks__: Use existing network for the swarm.

2. docker into the docker machine where you want to run letsencron.

Example:

` eval $(docker-machine env kylie-hub) `

3. Deploy the _docker-compose.yml_ file into a stack.

Example:

`docker stack deploy -c docker-compose.yml letsencron`

4. Make sure the stack is deployed and the service is running.

Run `docker stack ls` to see if the stack is deployed.
Then, run `docker ps` to see if the container is running. Take a note of the container ID.

5. Renew the certificate.

Example:

`docker exec -it 98897dc9d6f2 certbot certonly --webroot --webroot-path=/data/letsencrypt -d kjhub.seedbeauty.com`

_98897dc9d6f2_ is the container ID. 

_kjhub.seedbeauty.com_ is the site which you want to renew.

If it's successful, it would show semething similar to 
```
- Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/kjhub.seedbeauty.com/fullchain.pem
```

6. Nginx needs to be hotreloaded to reflect on the site.

Example:

`docker kill -s HUP ac1f61fa1d9d`

_ac1f61fa1d9d_ is the container id of nginx.

7. Check the website for the validity of the certificate.

## This section is for existing swarm setup.

### Letsencron container information is listed.
Follow step 5 above and onwards.

### Letsencron container information is not listed.

1. Run 

Example: 

`docker run -it --rm -v ~/data/certs:/etc/letsencrypt -v /shared/certs-data:/data/letsencrypt certbot/certbot certonly --webroot --webroot-path=/data/letsencrypt -d kyliehub.seedbeauty.com`

Change the site name to the site you want to renew.

Make sure all the paths are correct for __nginx__, __certs__ and __certs-data__.

2. If it's successful, it would show something similar to 
```
- Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/kjhub.seedbeauty.com/fullchain.pem
```

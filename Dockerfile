FROM certbot/certbot:v0.28.0

ENTRYPOINT ["/bin/busybox"]

COPY renewletsencrypt /etc/periodic/hourly/renewletsencrypt

CMD ["crond", "-f"]

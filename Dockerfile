FROM certbot/certbot:v0.28.0

ENTRYPOINT ["/bin/busybox"]

COPY letsencryptall /etc/periodic/monthly/letsencryptall

CMD ["crond", "-f"]

#!/bin/sh

certbot certonly --webroot --webroot-path=/data/letsencrypt -d $D

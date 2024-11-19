#!/bin/bash

docker pull certbot/certbox
docker pull nginx:stable-alpine
docker pull postgres:16-alpine
docker pull gitea/gitea:1
docker pull penpotapp/frontend:latest
docker pull penpotapp/backend:latest
docker pull penpotapp/exporter:latest
docker pull postgres:15
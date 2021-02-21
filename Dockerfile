FROM ubuntu:latest AS servidor  

LABEL "maintainer"="AndréAquilau" "version"="1.0.0" "description"="servidor linux ubuntu"

RUN apt-get update && apt-get upgrade && apt install curl


FROM alpine:latest
LABEL maintainer="dmpop@linux.com"
LABEL version="0.1"
LABEL description="Natsukashii container image"
RUN apk update
RUN apk add php-cli exiftool imagemagick sed coreutils curl ncftp
COPY . /usr/src/natsukashii
WORKDIR /usr/src/natsukashii
EXPOSE 8000

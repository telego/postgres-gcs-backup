FROM alpine:latest

RUN apk add --update \
  bash \
  postgresql \
  curl \
  python3 \
  py-pip \
  py-cffi \
  && pip install --upgrade pip \
  && apk add --virtual build-deps \
  gcc \
  libffi-dev \
  python3-dev \
  linux-headers \
  musl-dev \
  openssl-dev \
  && pip install gsutil \
  && apk del build-deps \
  && rm -rf /var/cache/apk/*

ADD . /postgres-gcs-backup

WORKDIR /postgres-gcs-backup

COPY backup.sh .

RUN chmod +x /postgres-gcs-backup/backup.sh

RUN pwd
RUN ls -l

ENTRYPOINT ["/postgres-gcs-backup/backup.sh"]

FROM python:3.11-alpine

RUN apk add --update \
  bash \
  postgresql16 \
  curl \
  && pip install gsutil \
  && rm -rf /var/cache/apk/*

ADD . /postgres-gcs-backup

WORKDIR /postgres-gcs-backup

COPY backup.sh .

RUN chmod +x /postgres-gcs-backup/backup.sh

RUN pwd
RUN ls -l

ENTRYPOINT ["/postgres-gcs-backup/backup.sh"]

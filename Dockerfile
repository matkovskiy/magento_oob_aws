FROM alpine:3.12
RUN adduser -u 1005 --disabled-password www-data && \
  mkdir -p /var/www/html && chown -R www-data  /var/www/html

RUN apk add aws-cli
# content
COPY --chown=www-data . /var/www/html
VOLUME ["/var/www/html"]
USER www-data

ENTRYPOINT ["sh", "/var/www/html/ops/entrypoint.sh"]
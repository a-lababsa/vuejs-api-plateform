FROM nginx:1.15.8-alpine AS app_nginx

COPY conf.d/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /app/app/public

VOLUME logs/nginx /var/log/nginx
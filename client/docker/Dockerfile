FROM alpine:latest AS client

RUN apk upgrade && \
    apk add --update npm && \
    npm install -yg yarn

RUN yarn global add @api-platform/client-generator

RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app

WORKDIR /app/client
FROM  alpine:latest AS api_admin

WORKDIR /app/admin

# prevent the reinstallation of node modules at every changes in the source code
COPY package.json ./
RUN set -eux; \
	apk add --no-cache --virtual .gyp \
		g++ \
		make \
		python \
	; \
	yarn install; \
	apk del .gyp

COPY . ./

VOLUME /app/admin/node_modules

CMD ["yarn", "start"]


FROM api_admin

RUN set -eux; \
	yarn build

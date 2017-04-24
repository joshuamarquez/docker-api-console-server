FROM nginx:alpine

MAINTAINER Joshua Marquez "joshua.marquezn@gmail.com"

# api-console version to use.
ENV API_CONSOLE_VERSION 3.0.16

# Install some tools.
RUN apk add --update wget unzip && rm -rf /var/cache/apk/*

# Download api-console.
RUN wget --no-check-certificate https://github.com/mulesoft/api-console/archive/v$API_CONSOLE_VERSION.zip -O console.zip

# Install api-console.
RUN unzip console.zip -d . \
 && rm -rf console.zip \
 && mv -f api-console-$API_CONSOLE_VERSION/dist /api-console-server \
 && rm -rf api-console-$API_CONSOLE_VERSION \
 && mkdir api-console-server/raml \
 && cp api-console-server/examples/simple.raml api-console-server/raml/api.raml \
 && rm -rf api-console-server/examples

# Define working directory.
WORKDIR /api-console-server

# Insert api RAML sample into index.html.
RUN sed -i 's/<raml-initializer><\/raml-initializer>/<raml-console-loader src="raml\/api.raml"><\/raml-console-loader>/g' /api-console-server/index.html

# Setup API Console Server using NGINX.
COPY nginx.conf /etc/nginx/conf.d/api_console_server.conf

EXPOSE 80
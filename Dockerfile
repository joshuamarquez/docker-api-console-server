FROM nginx:alpine

MAINTAINER Joshua Marquez "joshua.marquezn@gmail.com"

# api-console version to use.
ENV API_CONSOLE_VERSION 3.0.19

# Install some tools and remove apk cache.
RUN apk --no-cache add openssl

# Download api-console.
RUN wget https://github.com/mulesoft/api-console/archive/v$API_CONSOLE_VERSION.tar.gz -O console.tar.gz

# Install api-console.
RUN tar -xvf console.tar.gz \
 && rm -rf console.tar.gz \
 && mv -f api-console-$API_CONSOLE_VERSION/dist /api-console-server \
 && rm -rf api-console-$API_CONSOLE_VERSION \
 && mkdir api-console-server/raml \
 && cp api-console-server/examples/simple.raml api-console-server/raml/api.raml \
 && rm -rf api-console-server/examples

# Define working directory.
WORKDIR /api-console-server

# Insert api RAML sample into index.html.
RUN sed -i 's/<raml-initializer><\/raml-initializer>/<raml-console-loader src="raml\/api.raml"><\/raml-console-loader>/g' /api-console-server/index.html
RUN sed -i 's/src="/src="\//g' /api-console-server/index.html
RUN sed -i 's/href="/href="\//g' /api-console-server/index.html

# Setup API Console Server using NGINX.
COPY nginx.conf /etc/nginx/conf.d/api_console_server.conf

EXPOSE 80

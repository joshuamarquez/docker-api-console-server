# docker-api-console-server

Docker [api-console](https://github.com/mulesoft/api-console) NGINX based server to render your RAML docs.

## Install

```bash
$ docker pull joshuamarquez/api-console-server
```

## Quick example

```bash
$ docker run --name api_console_server -d -p 8080:80 joshuamarquez/api-console-server
```
then go to [localhost:8080](http://localhost:8080) and you will see the example RAML API.

## Use own RAML files

This image will load RAML file `api.raml` located inside container at `/api-console/raml`, so to
replace it and even add your own RAML files structure just mount a `VOLUME` like below.

```bash
$ docker run --name api_console_server -v $(pwd):/api-console/raml -d -p 8080:80 joshuamarquez/api-console-server
```

**Notes**

*   For the command above to work, a RAML file named `api.raml` should exists in the directory were command was ran and the same for any types, traits, securitySchemes, resourceTypes, etc.
*   For development you can use [docker-api-console](https://github.com/joshuamarquez/docker-api-console).

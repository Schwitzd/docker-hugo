# docker-hugo

This [Hugo](https://gohugo.io/) Docker image is intended to be very basic, mainly for use in build systems, and not for hosting a Hugo site beyond development.

At startup, a script is run to check if a Hugo website exists on the mounted folder. If not, the wizard will guide you to create it. If a Hugo website exists, it will be executed.

## Getting Started

Build the image

```bash
docker buildx build -t docker-hugo .
```

You can also specify a desired Hugo version during the build:

```bash
docker buildx build --build-arg HUGO_VERSION=0.127.0 -t docker-hugo .
```

Run server for development

```bash
docker run --rm -it -p 1313:1313 -u "$(id -u):$(id -g)" -v /host/site:/site docker-hugo server --bind 0.0.0.0 -D
```

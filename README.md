# docker-hugo

This [Hugo](https://gohugo.io/) Docker image is intended to be very basic, mainly for use in build systems, and not for hosting a Hugo site beyond development.

At startup, a script is run to check if a Hugo website exists on the mounted folder, if not, the wizard will guide you to create it. If a Hugo website exists, it will be executed.

## Usage

Build the image

```bash
docker build -t docker-hugo .
```

Run server for development

```bash
docker run --rm -it -p 1313:1313 -u "$(id -u):$(id -g)" -v /host/site:/site docker-hugo server --bind 0.0.0.0
```

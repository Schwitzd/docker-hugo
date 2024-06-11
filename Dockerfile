# Use Alpine Linux as base image
FROM alpine:latest

LABEL maintainer="Daniel Schwitzegbel"

# Copy the entrypoint script into the image
COPY hugo.sh /usr/local/bin/hugo.sh

# Set working directory
WORKDIR /site

VOLUME ["/site"]

ENV HUGO_VERSION 0.127.0

# Set execute permissions on the entrypoint & install Hugo
RUN apk update \
    && apk --update --no-cache add \
      curl \
      ca-certificates \
    && if [ "$(uname -m)" = "x86_64" ] ; then \
            HUGO_ARCH="amd64"; \
        elif [ "$(uname -m)" = "aarch64" ]; then \
            HUGO_ARCH="arm64"; \
        fi \
    && curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz" > /tmp/hugo.tar.gz \
    && mkdir /usr/local/hugo \
    && tar xzf /tmp/hugo.tar.gz -C /usr/local/hugo/ \
    && ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
    && apk del curl \
    && rm -rf /tmp/*

# Expose port 1313
EXPOSE 1313

# Set entrypoint to Hugo shell
ENTRYPOINT ["ash", "/usr/local/bin/hugo.sh"]
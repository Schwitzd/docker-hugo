# Use Alpine Linux as base image
FROM alpine:latest

LABEL maintainer="Daniel Schwitzgebel"

# Copy the entrypoint script into the image
COPY hugo.sh /usr/local/bin/hugo.sh

# Set working directory
WORKDIR /site

VOLUME ["/site"]

# Environment variable for Hugo version
ARG HUGO_VERSION

# Fetch the latest Hugo version if not specified
RUN apk update \
    && apk --update --no-cache add \
      curl \
      ca-certificates \
      jq \
    && if [ -z "$HUGO_VERSION" ]; then \
            HUGO_VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r '.tag_name' | tr -d 'v'); \
        fi \
    && if [ "$(uname -m)" = "x86_64" ]; then \
            HUGO_ARCH="amd64"; \
        elif [ "$(uname -m)" = "aarch64" ]; then \
            HUGO_ARCH="arm64"; \
        fi \
    && curl -L "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${HUGO_ARCH}.tar.gz" > /tmp/hugo.tar.gz \
    && mkdir /usr/local/hugo \
    && tar xzf /tmp/hugo.tar.gz -C /usr/local/hugo/ \
    && ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
    && apk del curl jq \
    && rm -rf /tmp/*

# Expose port 1313
EXPOSE 1313

# Set entrypoint to Hugo shell
ENTRYPOINT ["ash", "/usr/local/bin/hugo.sh"]

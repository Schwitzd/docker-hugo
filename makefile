NAME       := hugo
TAG        := $(shell sed -E -e '/HUGO_VERSION[ |=]/!d' -e 's/.*HUGO_VERSION[ |=|v]+([0-9\.]+).*/\1/' Dockerfile)
IMAGE_NAME := schwitzd/$(NAME)

.PHONY: build push clean
build:
	docker build --pull -t $(IMAGE_NAME):$(TAG) .

push:
	docker push $(IMAGE_NAME):$(TAG)

clean:
	docker rmi $(IMAGE_NAME):$(TAG) || true
emacs ?= emacs

BASEDIR := $(shell pwd)

build: 
	cd $(BASEDIR)
	sudo cp /home/user/.ssh/id_rsa .
	sudo DOCKER_BUILDKIT=1 docker build -t chendscm/basic --secret id=ssh_id,src=$(shell pwd)/id_rsa .

clean:
	sudo docker system prune --volumes

.PHONY: build clean

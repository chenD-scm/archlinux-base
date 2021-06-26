BASEDIR := $(shell pwd)

build: 
	cd $(BASEDIR)
	sudo DOCKER_BUILDKIT=1 docker build -t chendscm/basic --secret id=ssh_id,src=$(shell pwd)/id_rsa .

build-noCache:
	cd $(BASEDIR)
	sudo DOCKER_BUILDKIT=1 docker build --no-cache -t chendscm/basic --secret id=ssh_id,src=$(shell pwd)/id_rsa .

install:
	cd $(BASEDIR)
	mkdir git
	git clone git@github.com:cisco/ChezScheme git/ChezScheme

	sudo cp /home/user/.ssh/id_rsa .
	make build-noCache

clean:
	sudo docker system prune --volumes

.PHONY: build build-noCache clean install 

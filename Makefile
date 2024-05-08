SHELL	:= /bin/bash

BUILD	:= "$(PWD)/build"


build: .make-build-dir
	docker run --rm -w "/tmp/kibot" \
	-v "$(PWD)":/mnt/kibot:ro \
	-v "$(PWD)/build":/mnt/build \
	--user $(id -u):$(id -g) \
	-e dir=build \
	-e out_dir=build \
	ghcr.io/inti-cmnb/kicad6_auto_full:latest /bin/bash -c \
	"cp -r /mnt/kibot/* . && cp -r /mnt/kibot/.kibot . &&"\
	"kibot -d /mnt/build -c .kibot/config.kibot.yaml"\
	";chown -R $$(id -u):$$(id -g) /mnt/build"


.make-build-dir:
	mkdir -p "$(BUILD)"

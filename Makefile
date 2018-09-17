qemu-arm-static:
	curl --retry 3 -L -o qemu-arm-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/v2.6.0/qemu-arm-static.tar.gz && tar zx -f qemu-arm-static.tar.gz -C .
	rm qemu-arm-static.tar.gz

resin-xbuild: resin-xbuild.go
	GOOS=linux GOARCH=amd64 go build -ldflags "-w -s" resin-xbuild.go

build: resin-xbuild qemu-arm-static
	docker build --no-cache -t voronenko/arm-alpine-quemu:3.5 .

push:
	docker push voronenko/arm-alpine-quemu:3.5

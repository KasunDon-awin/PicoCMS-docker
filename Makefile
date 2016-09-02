all: build

build:
	docker build -t picocms -f docker/Dockerfile .

start: stop
	docker run -d -p 80:80 --name picocms picocms

stop:
	docker rm -vf picocms ||:
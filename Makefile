build:
	- chmod 777 scripts/protoc-gen.sh && chmod 777 scripts/build.sh
	- scripts/build.sh

docker:
	- chmod 777 scripts/build-docker.sh
	- scripts/build-docker.sh

protoc:
	- scripts/protoc-gen.sh

server:
	- go run api/main.go

dockerServer:
	- docker run -it -p 5001:5001 --name go-grpc-cache-container ashwaniyadav/go-grpc-cache

client:
	- go run examples/client.go

test:
	- go test api/server/* -v -cover -race

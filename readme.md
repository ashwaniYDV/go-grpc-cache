> In memory cache written in Go, using gRPC

## Contents

- [About](#about)
- [Running Server](#running-server)
    - [Local](#local)
    - [Docker](#docker)
- [API](#api)
    - [Add](#add)
    - [Get](#get)
    - [GetByPrefix](#getByPrefix)
    - [GetAllItems](#getallitems)
    - [DeleteKey](#deletekey)
    - [DeleteAll](#deleteall)
- [Testing](#testing)
- [Development](#development)
- [Example](#example)

## About

Go in memory cache using gRPC to generate API. Functionalities include

- Adding/Replacing key/value
- Getting value using a key
- Getting all keys
- Deleting a particular key
- Deleting all keys
- **Concurrency safe** and on client side calls can be made using goroutines

## Running server

You can run server locally the following ways

- Using go run
- Docker

### Local

You can run the server locally but make sure you have the following requirements

- [Golang min-version(1.11)](https://golang.org/)
- make

Now you can start the server using below commands

```bash
Start your server `./server-cache` or `make server`
`./server-cache -addr=":5001"` to run server on port `5001`
```

### Docker

Make sure you have following installed

- [Docker](https://www.docker.com/) installed

After the basic requirements are met, you can easily run server from below command.

- Run this command `make docker` // This will build the image
- Run the server using `make dockerServer`

After running the server, start your client `./client-cache` or `make client` in a different terminal

`./client-cache -addr=":5001"` is server is running running on port `5001`

## API

Proto syntax `proto3` is used. You can find the [proto file here](https://github.com/ashwaniYDV/go-grpc-cache/tree/master/proto/cache-service.proto)

### Add

This is used to add key/value to the cache

```go
func (c Cache) Add(ctx context.Context, item *api.Item) (*api.Item, error)
```

### Get

This is used to get key value pair for a particular key

```go
func (c Cache) Get(ctx context.Context, args *api.GetKey) (*api.Item, error)
```

### GetByPrefix

Used to get all key value pairs by prefix

```go
func (c Cache) GetByPrefix(ctx context.Context, args *api.GetKey) (*api.AllItems, error)
```

### GetAllItems

Used to get all key value pairs

```go
func (c Cache) GetAllItems(ctx context.Context, in *empty.Empty) (*api.AllItems, error)
```

### DeleteKey

Used to delete item by a particular key from the cache

```go
func (c Cache) DeleteKey(ctx context.Context, args *api.GetKey) (*api.Success, error)
```

### DeleteAll

Used to clear the whole cache

```go
func (c Cache) DeleteAll(ctx context.Context, in *empty.Empty) (*api.Success, error)
```

## Testing

After running `make build` just run `make test` to run the tests. It has **coverage of 92.7%**

```bash
go test api/server/* -v -cover -race
=== RUN   TestAdd
--- PASS: TestAdd (0.03s)
=== RUN   TestGet
--- PASS: TestGet (0.01s)
=== RUN   TestGetByPrefix
--- PASS: TestGetByPrefix (0.01s)
=== RUN   TestGetAllItems
--- PASS: TestGetAllItems (0.01s)
=== RUN   TestDeleteKey
--- PASS: TestDeleteKey (0.00s)
=== RUN   TestDeleteAll
--- PASS: TestDeleteAll (0.00s)
=== RUN   TestGetDeletedKey
--- PASS: TestGetDeletedKey (0.01s)
=== RUN   TestDeleteKeyByExpiration
--- PASS: TestDeleteKeyByExpiration (2.01s)
PASS
coverage: 92.7% of statements
ok  	command-line-arguments	3.709s	coverage: 92.7% of statements
```

## Development

You can develop and debug the application locally, but you need to have below softwares installed locally

- [Golang min-version(1.11)](https://golang.org/)
- make
- [protobuf](https://github.com/golang/protobuf)


Once you've cloned this repo, run these commands in this directory:

```bash
# Only needed the first time:
$ make build

# Then run to start server
$ ./server-cache --help

Usage of ./server-cache:
  -addr string
      Address on which you want to run server (default ":5001")
  -cln int
      Cleanup interval duration of expired cache is 5 min (default 5)
  -exp int
      Default expiration duration of cache is 10 min (default 10)

# To use client
$ ./client-cache --help

Usage of ./client-cache:
  -addr string
      Address on which you want to run server (default ":5001")
```

## Example

Please refer to [examples](https://github.com/ashwaniYDV/go-grpc-cache/tree/master/examples) directory for more information

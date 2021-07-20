# Protobuf Workspace

[![Protobuf Workspace CI](https://github.com/cragonnyunt/proto-workspace/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/cragonnyunt/proto-workspace/actions/workflows/main.yml)

Protobuf Workspace Docker is docker built for protocol buffer and GRPC code generator. It contains tools and plugins for protobuf and grpc code generation.

Set of tools installed
- protoc (Protobuf compiler)
- grpc_cpp_plugin
- grpc_csharp_plugin
- grpc_node_plugin
- grpc_objective_c_plugin
- grpc_php_plugin
- grpc_ruby_plugin
- protoc-gen-go
- protoc-gen-go-grpc

## Pulling the image

```sh
docker pull cragonnyunt/proto-workspace-docker
```

## Running the image

```sh
docker run --rm -it \
    -v $(pwd):/workspace \
    cragonnyunt/proto-workspace-docker
```

# Usage

To generate protocol buffers only,

```sh
protoc hellworld.proto --cpp_out=.
```

To generate protocol buffers + grpc client/server,

```sh
protoc hellworld.proto --cpp_out=. --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin`
```

More detail can be found at [GRPC](https://grpc.io/docs/) and [Protocol Buffers](https://developers.google.com/protocol-buffers/docs/tutorials) Documentations.

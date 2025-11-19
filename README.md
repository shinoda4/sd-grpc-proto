
```shell

go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest

# protobuf 消息生成器
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

# gRPC server/client 生成器
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

```

```shell
buf generate
```
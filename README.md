# Overview

Welcome to the **sd-grpc-proto** documentation.

## What is sd-grpc-proto?

The `sd-grpc-proto` repository is a centralized collection of Protocol Buffer (`.proto`) definitions for all gRPC services in the SD platform. It serves as the single source of truth for service contracts, ensuring consistency across microservices.

## Key Features

- **Centralized Definitions**: All proto files in one repository
- **Buf Workflow**: Modern protobuf tooling for linting and code generation
- **Versioned APIs**: Services organized by version (e.g., `auth/v1`)
- **HTTP/JSON Support**: grpc-gateway annotations for RESTful APIs
- **Generated Code**: Automatic Go code generation for messages, gRPC, and gateway

## Services

### Auth Service (v1)

**Package**: `auth.v1`  
**Location**: `auth/v1/auth.proto`

Provides authentication and user management functionality including registration, login, token management, and password reset.

**Documentation**: [Auth v1 API Reference](./auth/v1.md)

## Buf Workflow

This repository uses [Buf](https://buf.build) for managing Protocol Buffers:

### Linting

Ensures proto files follow best practices:

```bash
make lint
```

### Breaking Change Detection

Checks for breaking changes against a previous version:

```bash
make breaking
```

### Code Generation

Generates Go code, gRPC stubs, and grpc-gateway:

```bash
make generate
```

Configuration is in `buf.gen.yaml`:

- `go`: Go message types
- `go-grpc`: gRPC client/server code
- `grpc-gateway`: HTTP/JSON gateway

## Using This Repository

### As a Dependency

Import in your Go project:

```go
import authpb "github.com/shinoda4/sd-grpc-proto/proto/auth/v1"
```

### Generating Code

After modifying proto files:

```bash
make generate
```

## Building This Documentation

This documentation is built with **mdBook**:

```bash
make build
```

To serve locally:

```bash
make doc
# Or: mdbook serve -p 3000 ./docs
```

Then open [http://localhost:3000](http://localhost:3000)

## Next Steps

- [Auth API Reference](./auth/index.md) - Complete API documentation
- [README](../README.md) - Project setup and usage guide

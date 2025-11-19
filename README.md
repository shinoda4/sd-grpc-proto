# SD-GRPC-PROTO

Protocol Buffer definitions for the SD platform microservices.

## Overview

`sd-grpc-proto` is a centralized repository containing all Protocol Buffer (`.proto`) definitions for the SD platform's gRPC services. It uses [Buf](https://buf.build) for linting, breaking change detection, and code generation.

## Features

- **Centralized Proto Definitions**: Single source of truth for all service contracts
- **Buf Integration**: Modern protobuf workflow with linting and breaking change detection
- **Code Generation**: Automatic generation of Go code, gRPC stubs, and grpc-gateway
- **HTTP/JSON Support**: grpc-gateway annotations for RESTful HTTP APIs
- **Versioned APIs**: Organized by service and version (e.g., `auth/v1`)

## Repository Structure

```
sd-grpc-proto/
├── auth/
│   └── v1/
│       ├── auth.proto          # Auth service definitions
│       ├── auth.pb.go          # Generated Go messages
│       ├── auth_grpc.pb.go     # Generated gRPC client/server
│       └── auth.pb.gw.go       # Generated grpc-gateway
├── docs/                       # mdBook documentation
│   ├── book.toml
│   └── src/
│       ├── overview.md
│       └── auth_v1.md
├── buf.yaml                    # Buf configuration
├── buf.gen.yaml                # Code generation config
├── buf.lock                    # Dependency lock file
├── Makefile                    # Build commands
├── go.mod                      # Go module definition
└── README.md                   # This file
```

## Services

### Auth Service (v1)

**Package**: `auth.v1`  
**Proto File**: [auth/v1/auth.proto](auth/v1/auth.proto)

**RPCs**:
- `Register` - User registration
- `VerifyEmail` - Email verification
- `Login` - User authentication
- `Logout` - User logout
- `Me` - Get current user
- `ValidateToken` - Token validation
- `RefreshToken` - Token refresh
- `ForgotPassword` - Password reset request
- `ResetPassword` - Password reset completion

See [Auth v1 Documentation](docs/src/auth_v1.md) for detailed API reference.

## Prerequisites

### Install Buf

```bash
# macOS
brew install bufbuild/buf/buf

# Linux
curl -sSL "https://github.com/bufbuild/buf/releases/download/v1.28.1/buf-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/buf
chmod +x /usr/local/bin/buf
```

### Install Code Generation Plugins

```bash
# grpc-gateway
go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest

# Protocol Buffers Go plugin
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

# gRPC Go plugin
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

## Usage

### Generate Code

Generate Go code from proto definitions:

```bash
buf generate
```

Or using Make:

```bash
make gen
```

### Lint Proto Files

```bash
buf lint
```

### Check for Breaking Changes

```bash
buf breaking --against '.git#branch=main'
```

## Using in Go Projects

### Import the Module

Add to your `go.mod`:

```go
require github.com/shinoda4/sd-grpc-proto v0.1.0
```

### Use Generated Code

```go
import (
    authv1 "github.com/shinoda4/sd-grpc-proto/auth/v1"
    "google.golang.org/grpc"
)

// Create gRPC client
conn, err := grpc.Dial("localhost:50051", grpc.WithInsecure())
if err != nil {
    log.Fatal(err)
}
defer conn.Close()

client := authv1.NewAuthServiceClient(conn)

// Call RPC
resp, err := client.Login(context.Background(), &authv1.LoginRequest{
    Email:    "user@example.com",
    Password: "password",
})
```

## Development

### Project Layout

- **`auth/v1/`**: Auth service proto definitions (v1)
- **`buf.yaml`**: Buf configuration (linting rules, dependencies)
- **`buf.gen.yaml`**: Code generation configuration
- **`docs/`**: mdBook documentation

### Adding a New Service

1. Create service directory: `mkdir -p <service>/v1`
2. Add proto file: `<service>/v1/<service>.proto`
3. Update `buf.yaml` if needed
4. Run `buf generate`
5. Add documentation to `docs/src/`

### Buf Configuration

**`buf.yaml`**:
- Linting rules: Uses `DEFAULT` ruleset
- Breaking change detection: `FILE` level
- Dependencies: `googleapis` for HTTP annotations

**`buf.gen.yaml`**:
- `protoc-gen-go`: Generate Go message types
- `protoc-gen-go-grpc`: Generate gRPC client/server code
- `protoc-gen-grpc-gateway`: Generate HTTP/JSON gateway

## Documentation

Full documentation is available in the `docs/` directory using [mdbook](https://rust-lang.github.io/mdBook/).

### Build Documentation

```bash
cd docs
mdbook build
```

### Serve Documentation Locally

```bash
make doc
# Or: mdbook serve -p 3000 ./docs
```

Then open http://localhost:3000

## HTTP/JSON API

All services include grpc-gateway annotations for HTTP/JSON access. The generated gateway code allows clients to call gRPC services using standard HTTP requests.

**Example** (Auth Service):
```bash
# Register user
curl -X POST http://localhost:8080/api/v1/register \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","username":"john","password":"secret"}'

# Login
curl -X POST http://localhost:8080/api/v1/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"secret"}'
```

## Versioning

Services are versioned using directory structure:
- `auth/v1/` - Auth service version 1
- `auth/v2/` - Auth service version 2 (future)

Breaking changes require a new version. Non-breaking changes can be added to existing versions.

## Contributing

1. Make changes to `.proto` files
2. Run `buf lint` to check for issues
3. Run `buf breaking` to check for breaking changes
4. Run `buf generate` to regenerate code
5. Update documentation in `docs/src/`
6. Commit both proto and generated files

## License

Apache License 2.0
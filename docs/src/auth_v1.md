# Auth v1 API Reference

This document provides complete API reference for the `auth/v1/auth.proto` service definitions.

## Service: `AuthService`

**Package**: `auth.v1`  
**Go Package**: `github.com/shinoda4/sd-grpc-proto/auth/v1`

### RPC Methods

| RPC Method | HTTP Method | HTTP Path | Description |
|------------|-------------|-----------|-------------|
| `Register` | POST | `/api/v1/register` | Register a new user |
| `VerifyEmail` | GET | `/api/v1/verify` | Verify email address |
| `Login` | POST | `/api/v1/login` | Authenticate user |
| `Logout` | POST | `/api/v1/logout` | Logout user |
| `Me` | GET | `/api/v1/me` | Get current user info |
| `ValidateToken` | POST | `/api/v1/verify-token` | Validate access token |
| `RefreshToken` | POST | `/api/v1/refresh` | Refresh access token |
| `ForgotPassword` | POST | `/api/v1/forgot-password` | Request password reset |
| `ResetPassword` | POST | `/api/v1/reset-password` | Complete password reset |

---

## Message Definitions

### Register

#### `RegisterRequest`

```protobuf
message RegisterRequest {
  string email = 1;
  string username = 2;
  string password = 3;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `email` | `string` | User email address |
| `username` | `string` | Desired username |
| `password` | `string` | User password (will be hashed server-side) |

#### `RegisterResponse`

```protobuf
message RegisterResponse {
  string user_id = 1;
  string message = 2;
  string verify_token = 3;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | UUID of the newly created user |
| `message` | `string` | Status message (e.g., "registered") |
| `verify_token` | `string` | Email verification token |

---

### Verify Email

#### `VerifyEmailRequest`

```protobuf
message VerifyEmailRequest {
  string token = 1;
  bool send_email = 2;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `token` | `string` | Email verification token |
| `send_email` | `bool` | Whether to send verification email |

#### `VerifyEmailResponse`

```protobuf
message VerifyEmailResponse {
  string message = 1;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `message` | `string` | Verification result message |

---

### Login

#### `LoginRequest`

```protobuf
message LoginRequest {
  string email = 1;
  string password = 2;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `email` | `string` | User email address |
| `password` | `string` | User password |

#### `LoginResponse`

```protobuf
message LoginResponse {
  string access_token = 1;
  string refresh_token = 2;
  google.protobuf.Timestamp expires_in = 3;
  google.protobuf.Timestamp refresh_expires_in = 4;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `access_token` | `string` | JWT access token |
| `refresh_token` | `string` | JWT refresh token |
| `expires_in` | `google.protobuf.Timestamp` | Access token expiration time |
| `refresh_expires_in` | `google.protobuf.Timestamp` | Refresh token expiration time |

---

### Logout

#### `LogoutRequest`

```protobuf
message LogoutRequest {}
```

Empty message. Token is provided via gRPC metadata or HTTP Authorization header.

#### `LogoutResponse`

```protobuf
message LogoutResponse {
  string message = 1;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `message` | `string` | Logout confirmation message |

---

### Me (Get Current User)

#### `MeRequest`

```protobuf
message MeRequest {}
```

Empty message. User is identified from the access token in metadata/headers.

#### `MeResponse`

```protobuf
message MeResponse {
  string user_id = 1;
  string email = 2;
  google.protobuf.Timestamp expires_in = 3;
  google.protobuf.Timestamp issued_at = 4;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | User UUID |
| `email` | `string` | User email address |
| `expires_in` | `google.protobuf.Timestamp` | Token expiration time |
| `issued_at` | `google.protobuf.Timestamp` | Token issue time |

---

### Validate Token

#### `ValidateTokenRequest`

```protobuf
message ValidateTokenRequest {}
```

Empty message. Token is provided via gRPC metadata or HTTP Authorization header.

#### `ValidateTokenResponse`

```protobuf
message ValidateTokenResponse {
  bool valid = 1;
  string user_id = 2;
  string email = 3;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `valid` | `bool` | Whether the token is valid |
| `user_id` | `string` | User UUID (if valid) |
| `email` | `string` | User email (if valid) |

---

### Refresh Token

#### `RefreshTokenRequest`

```protobuf
message RefreshTokenRequest {}
```

Empty message. Refresh token is provided via gRPC metadata or HTTP Authorization header.

#### `RefreshTokenResponse`

```protobuf
message RefreshTokenResponse {
  string access_token = 1;
  google.protobuf.Timestamp expires_in = 2;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `access_token` | `string` | New JWT access token |
| `expires_in` | `google.protobuf.Timestamp` | New token expiration time |

---

### Forgot Password

#### `ForgotPasswordRequest`

```protobuf
message ForgotPasswordRequest {
  string email = 1;
  string username = 2;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `email` | `string` | User email address |
| `username` | `string` | Username |

#### `ForgotPasswordResponse`

```protobuf
message ForgotPasswordResponse {
  string message = 1;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `message` | `string` | Confirmation message |

---

### Reset Password

#### `ResetPasswordRequest`

```protobuf
message ResetPasswordRequest {
  string new_password = 1;
  string new_password_confirm = 2;
  string token = 3;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `new_password` | `string` | New password |
| `new_password_confirm` | `string` | Password confirmation |
| `token` | `string` | Password reset token (from email) |

#### `ResetPasswordResponse`

```protobuf
message ResetPasswordResponse {
  string message = 1;
}
```

| Field | Type | Description |
|-------|------|-------------|
| `message` | `string` | Reset confirmation message |

---

## Authentication

Most RPCs require authentication via Bearer token in metadata (gRPC) or Authorization header (HTTP).

### Public Endpoints (No Auth Required)

- `Register`
- `VerifyEmail`
- `Login`
- `ForgotPassword`
- `ResetPassword`

### Protected Endpoints (Auth Required)

- `Logout`
- `Me`
- `ValidateToken`
- `RefreshToken`

### gRPC Authentication

```go
md := metadata.Pairs("authorization", "Bearer "+accessToken)
ctx := metadata.NewOutgoingContext(context.Background(), md)
resp, err := client.Me(ctx, &authpb.MeRequest{})
```

### HTTP Authentication

```bash
curl -H "Authorization: Bearer <access_token>" \
  http://localhost:8080/api/v1/me
```

---

## Usage Examples

### gRPC Client (Go)

```go
import (
    authv1 "github.com/shinoda4/sd-grpc-proto/auth/v1"
    "google.golang.org/grpc"
    "google.golang.org/grpc/metadata"
)

// Connect to server
conn, err := grpc.Dial("localhost:50051", grpc.WithInsecure())
if err != nil {
    log.Fatal(err)
}
defer conn.Close()

client := authv1.NewAuthServiceClient(conn)

// Register
registerResp, err := client.Register(context.Background(), &authv1.RegisterRequest{
    Email:    "user@example.com",
    Username: "johndoe",
    Password: "securepassword",
})

// Login
loginResp, err := client.Login(context.Background(), &authv1.LoginRequest{
    Email:    "user@example.com",
    Password: "securepassword",
})

accessToken := loginResp.AccessToken

// Get current user (with auth)
md := metadata.Pairs("authorization", "Bearer "+accessToken)
ctx := metadata.NewOutgoingContext(context.Background(), md)

meResp, err := client.Me(ctx, &authv1.MeRequest{})
```

### HTTP/JSON Client

```bash
# Register
curl -X POST http://localhost:8080/api/v1/register \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","username":"john","password":"secret"}'

# Login
curl -X POST http://localhost:8080/api/v1/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"secret"}'

# Get current user
curl -X GET http://localhost:8080/api/v1/me \
  -H "Authorization: Bearer <access_token>"

# Refresh token
curl -X POST http://localhost:8080/api/v1/refresh \
  -H "Authorization: Bearer <refresh_token>" \
  -H "Content-Type: application/json" \
  -d '{}'
```

---

## Proto File Location

**File**: [`auth/v1/auth.proto`](../../auth/v1/auth.proto)

To view the complete proto definition, see the source file in the repository.


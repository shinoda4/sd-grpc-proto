# Auth v1 Documentation

This chapter documents the `auth/v1/auth.proto` file, which defines the `AuthService` and its RPC methods, along with all request and response messages.

---

## Service: `AuthService`

| RPC Method | Request Message | Response Message | HTTP Mapping |
|------------|----------------|-----------------|--------------|
| `Register` | `RegisterRequest` | `RegisterResponse` | `POST /api/v1/register` |
| `Login` | `LoginRequest` | `LoginResponse` | `POST /api/v1/login` |
| `ValidateToken` | `ValidateTokenRequest` | `ValidateTokenResponse` | `POST /api/v1/verify-token` |
| `RefreshToken` | `RefreshTokenRequest` | `RefreshTokenResponse` | `POST /api/v1/refresh` |
| `ForgotPassword` | `ForgotPasswordRequest` | `ForgotPasswordResponse` | `POST /api/v1/reset-password` |
| `ResetPassword` | `ResetPasswordRequest` | `ResetPasswordResponse` | `POST /api/v1/reset-password-confirm` |

---

## Message Definitions

### `RegisterRequest`
```proto
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
| `password` | `string` | Plain‑text password (will be hashed server‑side) |

### `RegisterResponse`
```proto
message RegisterResponse {
  string user_id = 1;
  string message = 2;
  string verify_token = 3;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `user_id` | `string` | Identifier of the newly created user |
| `message` | `string` | Human‑readable status message |
| `verify_token` | `string` | Token used for email verification |

### `LoginRequest`
```proto
message LoginRequest {
  string email = 1;
  string password = 2;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `email` | `string` | User email address |
| `password` | `string` | User password |

### `LoginResponse`
```proto
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
| `expires_in` | `google.protobuf.Timestamp` | Expiration time of the access token |
| `refresh_expires_in` | `google.protobuf.Timestamp` | Expiration time of the refresh token |

### `ValidateTokenRequest`
```proto
message ValidateTokenRequest {
  string access_token = 1;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `access_token` | `string` | JWT access token to validate |

### `ValidateTokenResponse`
```proto
message ValidateTokenResponse {
  bool valid = 1;
  string user_id = 2;
  string email = 3;
  string username = 4;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `valid` | `bool` | Whether the token is valid |
| `user_id` | `string` | User identifier (if valid) |
| `email` | `string` | User email (if valid) |
| `username` | `string` | Username (if valid) |

### `RefreshTokenRequest`
```proto
message RefreshTokenRequest {
  string refresh_token = 1;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `refresh_token` | `string` | JWT refresh token |

### `RefreshTokenResponse`
```proto
message RefreshTokenResponse {
  string access_token = 1;
  google.protobuf.Timestamp expires_in = 2;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `access_token` | `string` | New JWT access token |
| `expires_in` | `google.protobuf.Timestamp` | Expiration time of the new access token |

### `ForgotPasswordRequest`
```proto
message ForgotPasswordRequest {
  string email = 1;
  string username = 2;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `email` | `string` | User email address |
| `username` | `string` | Username (optional) |

### `ForgotPasswordResponse`
```proto
message ForgotPasswordResponse {
  string message = 1;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `message` | `string` | Confirmation message sent to the user |

### `ResetPasswordRequest`
```proto
message ResetPasswordRequest {
  string new_password = 1;
  string new_password_confirm = 2;
  string token = 3; // Usually needed for reset flow
}
```
| Field | Type | Description |
|-------|------|-------------|
| `new_password` | `string` | New password |
| `new_password_confirm` | `string` | Confirmation of the new password |
| `token` | `string` | Password‑reset token (from email) |

### `ResetPasswordResponse`
```proto
message ResetPasswordResponse {
  string message = 1;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `message` | `string` | Result of the password reset operation |

---

### `LogoutResponse`
```proto
message LogoutResponse {
  string message = 1;
}
```
| Field | Type | Description |
|-------|------|-------------|
| `message` | `string` | Result message for logout operation |

---


## Building the Documentation

The documentation is built with **mdBook**. Run the following command from the repository root:

```bash
mdbook build docs
```

The generated site will be available under `docs/book/`.

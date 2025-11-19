# Overview

Welcome to the **sd-grpc-proto** documentation.

## Repository Overview

The `sd-grpc-proto` repository contains Protocol Buffer (`.proto`) definitions for the various services used across the SD platform. These definitions are used to generate Go code via `buf` and serve as the contract for gRPC communication.

## Building the Documentation

The documentation is built using **mdBook**. To generate the static site:

```bash
cd /Users/carl/sd-system/sd-grpc-proto
mdbook build docs
```

The generated HTML files will be placed in `docs/book/`. Open `docs/book/index.html` in a browser to view the rendered documentation.

## Structure

- `docs/book.toml` – mdBook configuration.
- `docs/src/` – Markdown source files.
- `docs/src/overview.md` – This overview page.
- `docs/src/auth_v1.md` – Documentation for the `auth/v1/auth.proto` definitions.

Feel free to explore the individual chapters listed in the sidebar.

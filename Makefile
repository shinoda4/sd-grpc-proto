.PHONY: check-buf install-buf lint docs

check-buf:
	@echo "Checking if buf is installed..."
	@if command -v buf >/dev/null 2>&1; then \
		echo "✅ buf is installed"; \
	else \
		echo "❌ buf is NOT installed"; \
		exit 1; \
	fi

install-buf:
	@echo "Installing buf..."
	go install github.com/bufbuild/buf/cmd/buf@v1.28.1
	@echo "✅ buf installed"

lint:
	@echo "Preparing to lint..."
	@if ! command -v buf >/dev/null 2>&1; then \
		echo "buf not found, installing..."; \
		$(MAKE) install-buf; \
	else \
		echo "buf already installed"; \
	fi
	@echo "Running buf lint..."
	@buf lint
	@echo "✅ Lint completed"

breaking:
	@buf breaking --against '.git#branch=main'

generate:
	@buf generate

build:
	@echo "Building mdbook..."
	mdbook build ./docs
	@echo "Successful build book!"

docs:
	@echo "Starting mdbook server on port 3000..."
	mdbook serve -p 3000 ./docs
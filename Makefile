PROTOC_VERSION ?= 34.1
PROTOC_GEN_GO_VERSION ?= v1.36.11
PROTOC_GEN_GO_GRPC_VERSION ?= v1.6.1

.PHONY: generate-go tidy verify help

##@ Code Generation
generate-go: ## Generate Go gRPC stubs from proto/auth_service.proto
	protoc \
		--proto_path=proto \
		--go_out=go --go_opt=module=github.com/webdelo/auth-proto/go \
		--go-grpc_out=go --go-grpc_opt=module=github.com/webdelo/auth-proto/go \
		proto/auth_service.proto
	@cd go && go mod tidy

tidy: ## Tidy go module
	@cd go && go mod tidy

verify: ## Verify module builds
	@cd go && go build ./...

help: ## Show help
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*?##/ { printf "  %-20s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

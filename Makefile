PLUGIN_NAME=terraform-provider-traced
PLUGIN_VERSION=0.1.0
PROVIDER_TARGET=$(shell go env GOOS)_$(shell go env GOARCH)
PROVIDER_HOSTNAME=registry.hashicorp.io
PROVIDER_NAMESPACE=samplerepo
PROVIDER_TYPE=traced
PROVIDER_VERSION = 0.1.0

PLUGINS_PATH = ~/.terraform.d/plugins
PLUGINS_PROVIDER_PATH=$(PROVIDER_HOSTNAME)/$(PROVIDER_NAMESPACE)/$(PROVIDER_TYPE)/$(PROVIDER_VERSION)/$(PROVIDER_TARGET)

bin:
	@mkdir -p bin/

BIN=$(CURDIR)/bin
#$(BIN)/%:
#	@echo "Installing tools from tools/tools.go"
#	@cat tools/tools.go | grep _ | awk -F '"' '{print $$2}' | GOBIN=$(BIN) xargs -tI {} go install {}

.PHONY: build clean install_local

build: bin
	@echo "Building local provider binary"
	go build -o $(BIN)/terraform-provider-traced_v$(PROVIDER_VERSION)
	@sh -c "'$(CURDIR)/scripts/gen_dev_overrides.sh'"

clean:
	@echo "Deleting local provider binary"
	rm -rf $(BIN)

install_local: build
	@echo "Installing local provider binary to plugins mirror path $(PLUGINS_PATH)/$(PLUGINS_PROVIDER_PATH)"
	@mkdir -p $(PLUGINS_PATH)/$(PLUGINS_PROVIDER_PATH)
	@cp $(BIN)/terraform-provider-traced_v$(PROVIDER_VERSION) $(PLUGINS_PATH)/$(PLUGINS_PROVIDER_PATH)


all: build

tidy:
	go mod tidy

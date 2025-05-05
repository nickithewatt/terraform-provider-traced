# terraform-provider-traced

A sample Terraform provider using `terraform-plugin-sdk/v2`, written in Go 1.23.8, with OpenTelemetry tracing support.

## Features

- Implements a single resource `traced_example`
- Tracing enabled via stdout

## Requirements

- Go 1.23.8
- Terraform 1.0+

## Setup

```bash
asdf install golang 1.23.8
asdf local golang 1.23.8
make tidy
make install
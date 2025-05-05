terraform {
  required_providers {
    traced = {
      source  = "samplerepo/traced"
      version = "0.1.0"
    }
  }
}

resource "traced_example" "demo" {
  name = "hello-otel"
}
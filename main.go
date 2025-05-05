package main

import (
	"context"
	"log"

	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
	"github.com/nickithewatt/terraform-provider-traced/internal/provider"
)

func main() {
	shutdown := provider.InitTracer()
	defer func() {
		if err := shutdown(context.Background()); err != nil {
			log.Printf("Tracer shutdown error: %v", err)
		}
	}()

	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: provider.Provider,
	})
}

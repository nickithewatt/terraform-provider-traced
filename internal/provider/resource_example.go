package provider

import (
	"context"

	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"go.opentelemetry.io/otel/attribute"
)

func resourceExample() *schema.Resource {
	return &schema.Resource{
		Schema: map[string]*schema.Schema{
			"name": {
				Type:     schema.TypeString,
				Required: true,
			},
		},

		CreateContext: func(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
			ctx, span := tracer.Start(ctx, "CreateResource")
			defer span.End()

			name := d.Get("name").(string)
			span.SetAttributes(attribute.String("resource.name", name))

			d.SetId("demo-id-" + name)
			return nil
		},

		ReadContext: func(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
			ctx, span := tracer.Start(ctx, "ReadResource")
			defer span.End()
			return nil
		},

		UpdateContext: func(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
			ctx, span := tracer.Start(ctx, "UpdateResource")
			defer span.End()
			return nil
		},

		DeleteContext: func(ctx context.Context, d *schema.ResourceData, m interface{}) diag.Diagnostics {
			ctx, span := tracer.Start(ctx, "DeleteResource")
			defer span.End()
			d.SetId("")
			return nil
		},
	}
}

#!/bin/bash

BIN_DIR=$PWD/bin
OVERRIDES_FILENAME=developer_overrides.tfrc

cat << EOF > $BIN_DIR/$OVERRIDES_FILENAME
provider_installation {

  dev_overrides {
    "samplerepo/traced" = "$BIN_DIR"
  }

  direct {}
}
EOF

echo ""
echo "A development overrides file has been generated at ./bin/$OVERRIDES_FILENAME."
echo "To make Terraform temporarily use your locally built version of the provider, set TF_CLI_CONFIG_FILE within your terminal"
echo ""
printf '\texport TF_CLI_CONFIG_FILE=%s' "$BIN_DIR/$OVERRIDES_FILENAME"
echo ""
printf '\texport TF_LOG=TRACE'
echo ""
printf '\texport TF_LOG_PATH=%s/terraform.log' "$BIN_DIR"
echo ""

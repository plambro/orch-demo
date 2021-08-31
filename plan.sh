!#/usr/bin/env bash

set -euox pipefail

terraform plan \
  -var credentials_path=${CREDENTIALS_JSON_PATH} \
  -var private_key_path=${PRIVATE_KEY_PATH} \
  -var public_key_path=${PUBLIC_KEY_PATH} \
  -var project_name=crisp-demo \
  -out=.plan
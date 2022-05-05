#!/bin/bash

YAPF_COMMAND=$(yapf -p --diff --recursive .)
if [[ "${YAPF_COMMAND}" ]]; then
  echo "Please fix Python files format."
  echo "${YAPF_COMMAND}"
  exit 1
fi

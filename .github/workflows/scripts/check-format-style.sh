#!/bin/bash

YAPF_COMMAND=$(yapf -p --diff --recursive .)
if [[ "${YAPF_COMMAND}" ]]; then
  echo "Please fix Python files format using a command `yapf -p -i --recursive .`"
  echo "${YAPF_COMMAND}"
  exit 1
fi

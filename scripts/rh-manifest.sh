#!/usr/bin/env bash
#
# Generate rh-manifest.txt file.
# Run from repository root.
set -e
set -u

ELM_JSON="./ui/app/elm.json"
WORKING_FILE="$(mktemp /tmp/rh-manifest.XXXXXXXX)"

jq -r '.dependencies.direct + .dependencies.indirect |
   to_entries[] | [.key, .value] | @csv' "${ELM_JSON}" \
   >>"${WORKING_FILE}"

sort "${WORKING_FILE}" | uniq > rh-manifest.txt

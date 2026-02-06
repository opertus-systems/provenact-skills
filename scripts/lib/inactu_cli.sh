#!/usr/bin/env bash

resolve_inactu_cli() {
  local root_dir="$1"
  local inactu_root="${2:-$root_dir/../inactu}"

  if [[ -z "${INACTU_CLI_BIN:-}" ]]; then
    if command -v inactu-cli >/dev/null 2>&1; then
      INACTU_CLI_BIN="inactu-cli"
    elif [[ -x "$inactu_root/target/debug/inactu-cli" ]]; then
      INACTU_CLI_BIN="$inactu_root/target/debug/inactu-cli"
    elif [[ -d "$inactu_root" ]]; then
      echo "building inactu-cli..." >&2
      cargo build -p inactu-cli --manifest-path "$inactu_root/Cargo.toml" >/dev/null
      INACTU_CLI_BIN="$inactu_root/target/debug/inactu-cli"
    else
      echo "error: inactu-cli not found (set INACTU_CLI_BIN or provide inactu checkout)" >&2
      return 1
    fi
  fi

  if ! command -v "$INACTU_CLI_BIN" >/dev/null 2>&1 && [[ ! -x "$INACTU_CLI_BIN" ]]; then
    echo "error: configured INACTU_CLI_BIN is not executable: $INACTU_CLI_BIN" >&2
    return 1
  fi

  return 0
}

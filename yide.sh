#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

VARIANTS=(codercom linuxserver openvscode theia)
PORTS=(3010 3020 3030 3040)
URLS=(
  "http://localhost:3010  (no auth)"
  "http://localhost:3020  (no auth)"
  "http://localhost:3030  (no auth)"
  "http://localhost:3040  (no auth)"
)

usage() {
  echo "Usage: $0 <variant> [up|down|logs]"
  echo ""
  echo "Variants:"
  for i in "${!VARIANTS[@]}"; do
    printf "  %-12s  port %s  →  %s\n" "${VARIANTS[$i]}" "${PORTS[$i]}" "${URLS[$i]}"
  done
  echo ""
  echo "Examples:"
  echo "  $0 codercom        # start codercom"
  echo "  $0 openvscode down # stop openvscode"
  echo "  $0 theia logs"
  exit 1
}

[[ $# -eq 0 ]] && usage

VARIANT=$1
CMD=${2:-up}

valid=0
for v in "${VARIANTS[@]}"; do [[ "$v" == "$VARIANT" ]] && valid=1; done
[[ $valid -eq 0 ]] && { echo "Unknown variant: $VARIANT"; echo ""; usage; }

cd "$SCRIPT_DIR/$VARIANT"

case "$CMD" in
  up)
    docker compose up -d
    for i in "${!VARIANTS[@]}"; do
      if [[ "${VARIANTS[$i]}" == "$VARIANT" ]]; then
        echo "Ready at: ${URLS[$i]}"
      fi
    done
    ;;
  down)
    docker compose down
    ;;
  logs)
    docker compose logs -f
    ;;
  *)
    echo "Unknown command: $CMD (use up, down, or logs)"
    exit 1
    ;;
esac

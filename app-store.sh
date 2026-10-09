#!/bin/bash
# pi-app-store: 1
set -eu
cd -- "$(dirname -- "$0")"
case "${1:-}" in
  install) bash -n hotspot.sh; python3 -c 'import curses;compile(open("hotspot_menu.py").read(),"hotspot_menu.py","exec")' ;;
  run) exec python3 hotspot_menu.py ;;
  *) echo "Use: bash app-store.sh install OR bash app-store.sh run"; exit 1 ;;
esac

#!/bin/bash
# Manual duplex printing for printers without a duplex unit.
# usage: ./duplex-print.sh document.pdf [printer-name]
set -euo pipefail

FILE="${1:?usage: duplex-print.sh <file> [printer]}"
[[ -r "$FILE" ]] || { echo "Cannot read '$FILE'" >&2; exit 1; }

# Use the given printer, otherwise the system default
PRINTER="${2:-$(lpstat -d 2>/dev/null | sed -n 's/^system default destination: //p')}"
[[ -n "$PRINTER" ]] || { echo "No printer given and no default printer set (lpoptions -d <name>)" >&2; exit 1; }

lp -d "$PRINTER" -o page-set=odd -o sides=one-sided "$FILE"
read -rp "Odd pages printed. Flip the stack and reload it, then press Enter to print the even pages..."
lp -d "$PRINTER" -o page-set=even -o sides=one-sided -o outputorder=reverse "$FILE"

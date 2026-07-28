#!/bin/bash
# usage: ./duplex-print.sh document.pdf [printer-name]
FILE="$1"
PRINTER="${2:-$(lpstat -d | awk '{print $NF}')}"   # uses your default printer if none given

lp -d "$PRINTER" -o page-set=odd -o sides=one-sided "$FILE"
read -rp "Odd pages printed. Flip the stack and reload it, then press Enter to print the even pages..."
lp -d "$PRINTER" -o page-set=even -o outputorder=reverse "$FILE"

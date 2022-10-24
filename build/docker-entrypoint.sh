#!/usr/bin/env bash
set -Eeo pipefail
trap _term SIGTERM

log="/opt/calibre-web/calibre-web.log"

echo "Starting Calibre Web " | sed -u "s/.*/` printf "calibre-web   |" ` &/"

python3 /opt/calibre-web/cps.py -v | sed -u "s/.*/` printf "calibre-web   |" ` &/"

while [ ! -f $log ]; do sleep 1 ; done && tail -f $log | sed -u "s/.*/` printf "calibre-web   |" ` &/" & 

exec /bin/bash -c "python3 /opt/calibre-web/cps.py | sed -u \"s/.*/` printf \"calibre-web   |\" ` &/\" " 



#!/usr/bin/env bash

set -e

if [ ! -p pgpass ]; then 
    mkfifo pgpass
fi

(
    trap "exit" INT TERM
    trap "rm pgpass && kill 0" EXIT
    while true; do
        echo "$(date) - $BASHPID" > pgpass
    done
) &

exec date

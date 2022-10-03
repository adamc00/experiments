#!/usr/bin/env bash

set -e

(
    trap "exit" INT TERM
    trap "rm pgpass && kill 0" EXIT

    if [ ! -p pgpass ]; then 
        mkfifo pgpass
    fi

    while true; do
        echo "$(date) - $BASHPID" > pgpass
    done
) &

exec date

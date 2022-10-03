#!/usr/bin/env bash

set -e

(
    trap "exit" INT TERM
    trap "rm /secrets/pgpass && kill 0" EXIT

    if [ ! -p /secrets/pgpass ]; then 
        mkfifo -m 0600 /secrets/pgpass
    fi

    while true; do
        echo "*:*:example:example:password" > /secrets/pgpass
    done
) &
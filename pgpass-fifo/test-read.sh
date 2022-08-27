#!/usr/bin/env bash

set -e

trap "exit" INT TERM
trap "rm pgpass && kill 0" EXIT

while true; do
    echo "$(date) - $BASHPID"
    cat pgpass
    sleep 2
    echo
done


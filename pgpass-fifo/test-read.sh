#!/usr/bin/env bash

set -e

trap "exit" INT TERM
trap "kill 0" EXIT

while true; do
    echo "$(date) - $BASHPID"
    cat pgpass
    sleep 2
    echo
done


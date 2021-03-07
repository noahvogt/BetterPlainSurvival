#!/bin/sh

if [ $# != 1 ]; then
    echo "Error: Usage: install.sh [output (mods) dir]" 1>&2
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Error: directory $1 not found or missing permissions" 1>&2
    exit 1
fi

if ! command -v "wget" > /dev/null 2>&1; then
    echo "Error: installation of 'wget' not found in \$PATH" 1>&2
    exit 1
fi

wget -q --show-progress -P "$1" --input-file="file-list"

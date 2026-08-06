#!/bin/sh

if [ $# != 2 ]; then
    echo "Error: Usage: install.sh [file list] [output (mods) dir]" 1>&2
    exit 1
fi

if [ ! -f "$1" ]; then
    echo "Error: file list '$1' not found or not readable" 1>&2
    exit 1
fi

if [ ! -d "$2" ]; then
    echo "Error: directory '$2' not found or missing permissions" 1>&2
    exit 1
fi

if command -v wget > /dev/null 2>&1; then
    wget -q --show-progress -P "$2" --input-file="$1"
elif command -v curl > /dev/null 2>&1; then
    while IFS= read -r url || [ -n "$url" ]; do
        [ -z "$url" ] && continue
        filename="${url##*/}"
        echo "Downloading $filename..."
        curl -# -L -o "$2/$filename" "$url"
    done < "$1"
else
    echo "Error: neither 'wget' nor 'curl' found in \$PATH" 1>&2
    exit 1
fi

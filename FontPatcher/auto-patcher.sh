#!/bin/bash

if [ $# -eq 0 ]; then
    exit 1
fi

in_dir="$1"

if [ ! -d "$in_dir" ]; then
    echo "ERROR: Directory '$in_dir' does not exist"
    exit 1
fi

out_dir="$in_dir/nerd-font"

mkdir -p "$out_dir"

for file in "$in_dir"/*.ttf; do
    if [ -e "$file" ]; then
        echo "Patching: $file"
        fontforge -script ./font-patcher "$file" --outputdir "$out_dir/" --complete
    else
        echo "No .ttf files"
        rm -rf "$out_dir"
        break
    fi
done

#!/bin/bash

if [ $# -eq 0 ]; then
    exit 1
fi

in_dir="$1"

if [ ! -d "$in_dir" ]; then
    echo "ERROR: Directory '$in_dir' does not exist"
    exit 1
fi

echo "Installing dependencies for Ubuntu..."
sudo apt update
sudo apt install python3
sudo apt install fontforge python3-fontforge

out_dir="$in_dir/nerd-font"

mkdir -p "$out_dir"

for file in "$in_dir"/*; do
    if [ -e "$file" ]; then
        echo "Patching: $file"
        fontforge -script ./font-patcher "$file" --outputdir "$out_dir/" --complete
    else
        rm -rf "$out_dir"
        break
    fi
done

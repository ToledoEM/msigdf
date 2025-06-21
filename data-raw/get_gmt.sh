#!/bin/bash

# Directories
HUMAN_DIR="human_gmt"
MOUSE_DIR="mouse_gmt"
URL_FILE="data_url.yml"

mkdir -p "$HUMAN_DIR" "$MOUSE_DIR"

# Download human files
grep -A 1000 '^human:' "$URL_FILE" | grep -B 1000 '^mouse:' | grep -Eo 'ftp://[^"]+' | while read -r url; do
    fname=$(basename "$url")
    curl -fLo "$HUMAN_DIR/$fname" "$url"
done

# Download mouse files
grep -A 1000 '^mouse:' "$URL_FILE" | grep -Eo 'ftp://[^"]+' | while read -r url; do
    fname=$(basename "$url")
    curl -fLo "$MOUSE_DIR/$fname" "$url"
done
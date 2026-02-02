#!/bin/bash

# Directories
HUMAN_DIR="human_gmt"
MOUSE_DIR="mouse_gmt"
URL_FILE="data_url.yml"

mkdir -p "$HUMAN_DIR" "$MOUSE_DIR"

# Extract list items for a given top-level YAML key.
extract_urls() {
    local section="$1"
    awk -v section="$section" '
        $0 ~ "^[[:space:]]*" section ":" { in_section=1; next }
        in_section && $0 ~ "^[[:space:]]*[A-Za-z0-9_]+:" { in_section=0 }
        in_section && $0 ~ "^[[:space:]]*-" {
            sub("^[[:space:]]*-[[:space:]]*", "", $0)
            print $0
        }
    ' "$URL_FILE"
}

# Download human files
extract_urls "human" | while read -r url; do
    fname=$(basename "$url")
    curl -fLo "$HUMAN_DIR/$fname" "$url"
done

# Download mouse files
extract_urls "mouse" | while read -r url; do
    fname=$(basename "$url")
    curl -fLo "$MOUSE_DIR/$fname" "$url"
done

#check downloads were successful
human_expected_files=$(extract_urls "human" | xargs -n1 basename | sort)
human_downloaded_files=$(find "$HUMAN_DIR" -maxdepth 1 -type f -printf "%f\n" | sort)
human_missing=$(comm -23 <(printf "%s\n" "$human_expected_files") <(printf "%s\n" "$human_downloaded_files"))
human_extra=$(comm -13 <(printf "%s\n" "$human_expected_files") <(printf "%s\n" "$human_downloaded_files"))
if [ -n "$human_missing" ] || [ -n "$human_extra" ]; then
    echo "Human download check failed." >&2
    [ -n "$human_missing" ] && echo "Missing human files:"$'\n'"$human_missing" >&2
    [ -n "$human_extra" ] && echo "Extra human files:"$'\n'"$human_extra" >&2
    exit 1
else
    echo "Human download check passed ($(printf "%s\n" "$human_expected_files" | wc -l | tr -d '[:space:]') files)."
fi

mouse_expected_files=$(extract_urls "mouse" | xargs -n1 basename | sort)
mouse_downloaded_files=$(find "$MOUSE_DIR" -maxdepth 1 -type f -printf "%f\n" | sort)
mouse_missing=$(comm -23 <(printf "%s\n" "$mouse_expected_files") <(printf "%s\n" "$mouse_downloaded_files"))
mouse_extra=$(comm -13 <(printf "%s\n" "$mouse_expected_files") <(printf "%s\n" "$mouse_downloaded_files"))
if [ -n "$mouse_missing" ] || [ -n "$mouse_extra" ]; then
    echo "Mouse download check failed." >&2
    [ -n "$mouse_missing" ] && echo "Missing mouse files:"$'\n'"$mouse_missing" >&2
    [ -n "$mouse_extra" ] && echo "Extra mouse files:"$'\n'"$mouse_extra" >&2
    exit 1
else
    echo "Mouse download check passed ($(printf "%s\n" "$mouse_expected_files" | wc -l | tr -d '[:space:]') files)."
fi

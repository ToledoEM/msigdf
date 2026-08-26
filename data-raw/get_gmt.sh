#!/bin/bash
#
# Download the MSigDB GMT files listed in data_url.yml.
#
# Run from anywhere; paths resolve relative to this script:
#   bash data-raw/get_gmt.sh
#
# Files land in data-raw/human_gmt/ and data-raw/mouse_gmt/, which are not
# tracked in the repository. Then build the data frames with:
#   Rscript data-raw/msigdf.R

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

HUMAN_DIR="$SCRIPT_DIR/human_gmt"
MOUSE_DIR="$SCRIPT_DIR/mouse_gmt"
URL_FILE="$SCRIPT_DIR/data_url.yml"

if [ ! -f "$URL_FILE" ]; then
    echo "Missing URL file: $URL_FILE" >&2
    exit 1
fi

mkdir -p "$HUMAN_DIR" "$MOUSE_DIR"

# Read the top-level `version:` key.
extract_version() {
    awk '/^version:/ { sub("^version:[[:space:]]*", "", $0); print $0; exit }' "$URL_FILE"
}

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

# List plain file names in a directory. Portable: BSD/macOS find has no -printf.
list_files() {
    local dir="$1"
    find "$dir" -maxdepth 1 -type f -exec basename {} \; | sort
}

download_section() {
    local section="$1" dir="$2"
    local url fname count=0

    while read -r url; do
        [ -n "$url" ] || continue
        fname="$(basename "$url")"
        curl -fLo "$dir/$fname" "$url"
        count=$((count + 1))
    done < <(extract_urls "$section")

    if [ "$count" -eq 0 ]; then
        echo "No $section URLs found in $URL_FILE" >&2
        exit 1
    fi
}

# Compare what the YAML asked for against what landed on disk.
check_downloads() {
    local section="$1" dir="$2"
    local expected downloaded missing extra

    expected="$(extract_urls "$section" | xargs -n1 basename | sort)"
    downloaded="$(list_files "$dir")"
    missing="$(comm -23 <(printf "%s\n" "$expected") <(printf "%s\n" "$downloaded"))"
    extra="$(comm -13 <(printf "%s\n" "$expected") <(printf "%s\n" "$downloaded"))"

    if [ -n "$missing" ] || [ -n "$extra" ]; then
        echo "${section} download check failed." >&2
        [ -n "$missing" ] && echo "Missing ${section} files:"$'\n'"$missing" >&2
        [ -n "$extra" ] && echo "Extra ${section} files:"$'\n'"$extra" >&2
        return 1
    fi

    echo "${section} download check passed ($(printf "%s\n" "$expected" | wc -l | tr -d '[:space:]') files)."
}

# Every downloaded file must carry the version declared in the YAML, otherwise
# the URL list is stale and the build would silently produce empty data frames.
check_version() {
    local section="$1" dir="$2" version="$3"
    local mismatched

    mismatched="$(list_files "$dir" | grep -v -F ".v${version}." || true)"
    if [ -n "$mismatched" ]; then
        echo "${section} version check failed (expected v${version}):"$'\n'"$mismatched" >&2
        return 1
    fi

    echo "${section} version check passed (v${version})."
}

VERSION="$(extract_version)"
if [ -z "$VERSION" ]; then
    echo "No version found in $URL_FILE" >&2
    exit 1
fi
echo "MSigDB version: $VERSION"

download_section "human" "$HUMAN_DIR"
download_section "mouse" "$MOUSE_DIR"

check_downloads "human" "$HUMAN_DIR"
check_downloads "mouse" "$MOUSE_DIR"

check_version "human" "$HUMAN_DIR" "$VERSION"
check_version "mouse" "$MOUSE_DIR" "$VERSION"

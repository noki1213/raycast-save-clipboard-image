#!/bin/bash

# Saves clipboard image to Downloads only when the image content changes.
# Intended to be run repeatedly by launchd StartInterval.

set -u

PNGPATH="/opt/homebrew/bin/pngpaste"
MDIMPORT="/usr/bin/mdimport"
XATTR="/usr/bin/xattr"
# Binary plist (boolean true) for com.apple.metadata:kMDItemIsScreenCapture
SCREENSHOT_TRUE_BPLIST_HEX="62706c697374303009080000000000000101000000000000000100000000000000000000000000000009"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SAVE_PATH="$HOME/Downloads/clipboard_${TIMESTAMP}.png"
STATE_DIR="$HOME/.local/state/raycast-save-clipboard-image"
LAST_HASH_FILE="$STATE_DIR/last_image_sha256"
TMP_FILE=$(mktemp "/tmp/clipboard-image.XXXXXX.png")

cleanup() {
  rm -f "$TMP_FILE"
}
trap cleanup EXIT

mkdir -p "$STATE_DIR"

if ! "$PNGPATH" "$TMP_FILE" >/dev/null 2>&1; then
  exit 0
fi

CURRENT_HASH=$(shasum -a 256 "$TMP_FILE" | awk '{print $1}')
LAST_HASH=""

if [ -f "$LAST_HASH_FILE" ]; then
  LAST_HASH=$(cat "$LAST_HASH_FILE")
fi

if [ "$CURRENT_HASH" = "$LAST_HASH" ]; then
  exit 0
fi

mv "$TMP_FILE" "$SAVE_PATH"

if ! "$XATTR" -wx com.apple.metadata:kMDItemIsScreenCapture "$SCREENSHOT_TRUE_BPLIST_HEX" "$SAVE_PATH"; then
  echo "Saved, but failed to set screenshot metadata: $SAVE_PATH" >&2
else
  if ! "$MDIMPORT" "$SAVE_PATH" >/dev/null 2>&1; then
    echo "Saved, but failed to refresh Spotlight index: $SAVE_PATH" >&2
  fi
fi

printf '%s\n' "$CURRENT_HASH" > "$LAST_HASH_FILE"
echo "Saved: $SAVE_PATH"

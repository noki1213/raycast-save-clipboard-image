#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Save Clipboard Image & Copy Path
# @raycast.mode silent
# @raycast.icon 🖼️
# @raycast.packageName Clipboard

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SAVE_PATH="$HOME/Downloads/clipboard_${TIMESTAMP}.png"

/opt/homebrew/bin/pngpaste "$SAVE_PATH"

if [ $? -eq 0 ]; then
    echo -n "$SAVE_PATH" | pbcopy
    echo "Saved and path copied"
else
    echo "No image in clipboard"
fi

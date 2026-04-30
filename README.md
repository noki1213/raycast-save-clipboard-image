# raycast-save-clipboard-image

A Raycast script that saves a clipboard image to your Downloads folder and copies the file path to your clipboard.

## What it does

1. Saves the image currently in your clipboard as a PNG file to `~/Downloads/`
2. The filename includes a timestamp (e.g. `clipboard_20260430_143022.png`)
3. Copies the full file path to your clipboard automatically

## Requirements

- [Raycast](https://www.raycast.com/)
- [pngpaste](https://github.com/jcsalterego/pngpaste) — install via Homebrew:

```sh
brew install pngpaste
```

## Setup

1. Clone or download this repository
2. Open Raycast Settings → Extensions → Script Commands
3. Add the folder containing `clipboard-image-save.sh`
4. Make sure the script is executable:

```sh
chmod +x clipboard-image-save.sh
```

## Usage

1. Copy any image to your clipboard (screenshot, image from browser, etc.)
2. Open Raycast and run "Save Clipboard Image & Copy Path"
3. The image is saved to `~/Downloads/` and the path is ready to paste

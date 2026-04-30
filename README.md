# raycast-save-clipboard-image

A Raycast script that saves a clipboard image to your Downloads folder and copies the file path to your clipboard.

This repository also includes an auto-save script for Universal Clipboard workflows (iPhone/iPad -> Mac).

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

To use auto-save, also make this script executable:

```sh
chmod +x clipboard-image-auto-save.sh
```

## Usage

1. Copy any image to your clipboard (screenshot, image from browser, etc.)
2. Open Raycast and run "Save Clipboard Image & Copy Path"
3. The image is saved to `~/Downloads/` and the path is ready to paste

## Auto-save (no Raycast action needed)

`clipboard-image-auto-save.sh` is designed for background automation.

- It checks clipboard images repeatedly
- Saves only when image content changed (prevents duplicate files)
- Saves to `~/Downloads/clipboard_YYYYMMDD_HHMMSS.png`

### Enable with launchd

1. Create `~/Library/LaunchAgents/com.noki.clipboard-image-auto-save.plist` with this content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.noki.clipboard-image-auto-save</string>
    <key>ProgramArguments</key>
    <array>
      <string>/Users/YOUR_USER_NAME/path/to/raycast-save-clipboard-image/clipboard-image-auto-save.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>2</integer>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/clipboard-image-auto-save.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/clipboard-image-auto-save.error.log</string>
  </dict>
</plist>
```

2. Replace the script path with your real absolute path.
3. Load it:

```sh
launchctl unload ~/Library/LaunchAgents/com.noki.clipboard-image-auto-save.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.noki.clipboard-image-auto-save.plist
```

4. Confirm status:

```sh
launchctl list | grep com.noki.clipboard-image-auto-save
```

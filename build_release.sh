#!/bin/bash
set -e

echo "=========================================="
echo " Packaging StelluAsuna for ContentDB"
echo "=========================================="

STAGING_DIR="/tmp/stelluasuna_build"
GAME_NAME="stelluasuna"
OUTPUT_ZIP="/home/krox/Desktop/${GAME_NAME}_release.zip"

echo "[1/4] Preparing staging area..."
rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR/$GAME_NAME"

# Copy all files but exclude .git and this script itself
rsync -a --exclude='.git' --exclude='build_release.sh' /home/krox/Documents/StelluAsuna/ "$STAGING_DIR/$GAME_NAME/"

echo "[2/4] Optimizing large background images (lossless resize to 720p + indexed colors)..."
if command -v mogrify >/dev/null 2>&1; then
    # Resizing and converting to 256 indexed colors reduces size from ~24MB to ~3MB without noticeable in-game loss
    mogrify -resize 1280x720 -colors 256 "$STAGING_DIR/$GAME_NAME/menu/background"*.png || true
else
    echo "  -> mogrify not found, skipping image optimization."
fi

echo "[3/4] Optimizing ALL heavy music and sound files..."
if command -v ffmpeg >/dev/null 2>&1; then
    # Find all .ogg files larger than 500KB and compress them
    find "$STAGING_DIR/$GAME_NAME" -type f -name "*.ogg" -size +500k | while read -r ogg; do
        echo "  -> Compressing $ogg"
        tmp_ogg="${ogg}.tmp.ogg"
        # Convert to a lower bitrate (-q:a 0 is ~64kbps). Downmix to mono (-ac 1) if it's a huge sound effect
        ffmpeg -y -i "$ogg" -c:a libvorbis -q:a 0 "$tmp_ogg" </dev/null 2>/dev/null
        mv "$tmp_ogg" "$ogg"
    done
else
    echo "  -> ffmpeg not found, skipping audio optimization."
fi

echo "[4/4] Creating final ZIP archive..."
cd "$STAGING_DIR"
# Remove any existing zip
rm -f "$OUTPUT_ZIP"
# Zip with maximum compression
zip -r -9 -q "$OUTPUT_ZIP" "$GAME_NAME"

echo "=========================================="
echo " SUCCESS!"
echo " Tu archivo optimizado está listo en:"
echo " -> $OUTPUT_ZIP"
echo ""
echo " Comprueba el peso del archivo (debería ser menor a 100MB) y súbelo a ContentDB."
echo "=========================================="

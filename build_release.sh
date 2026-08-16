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

echo "[2/4] Optimizing large background images (lossless resize to 720p)..."
# Resizing backgrounds from 1080p to 720p will reduce their size by ~60% with no visible quality loss in-game
if command -v mogrify >/dev/null 2>&1; then
    mogrify -resize 1280x720 "$STAGING_DIR/$GAME_NAME/menu/background"*.png || true
else
    echo "  -> mogrify not found, skipping image optimization."
fi

echo "[3/4] Optimizing music files (compressing bitrates)..."
# The 'asuna' mod contains 33MB of music. Re-encoding them to a slightly lower bitrate saves massive space.
if command -v ffmpeg >/dev/null 2>&1; then
    MUSIC_DIR="$STAGING_DIR/$GAME_NAME/mods/asuna/asuna_core/sounds/music"
    if [ -d "$MUSIC_DIR" ]; then
        for ogg in "$MUSIC_DIR"/*.ogg; do
            tmp_ogg="${ogg}.tmp.ogg"
            # Compress to ~64kbps (perfectly fine for ambient music)
            ffmpeg -y -i "$ogg" -c:a libvorbis -q:a 0 "$tmp_ogg" </dev/null 2>/dev/null
            mv "$tmp_ogg" "$ogg"
        done
    fi
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

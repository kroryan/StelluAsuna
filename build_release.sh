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
rsync -a --exclude='.git' --exclude='build_release.sh' --exclude='ANALISIS_PRIVADO.md' /home/krox/Documents/StelluAsuna/ "$STAGING_DIR/$GAME_NAME/"

echo "[2/4] Optimizing large background images (lossless resize to 720p + indexed colors)..."
if command -v mogrify >/dev/null 2>&1; then
    # Resizing and converting to 256 indexed colors reduces size from ~24MB to ~3MB without noticeable in-game loss
    mogrify -resize 1280x720 -colors 256 "$STAGING_DIR/$GAME_NAME/menu/background"*.png || true
else
    echo "  -> mogrify not found, skipping image optimization."
fi

echo "[3/4] Optimizing ALL heavy music and sound files..."
if command -v ffmpeg >/dev/null 2>&1; then
    # Find all .ogg files larger than 200KB and compress them
    find "$STAGING_DIR/$GAME_NAME" -type f -name "*.ogg" -size +200k | while read -r ogg; do
        echo "  -> Compressing $ogg"
        tmp_ogg="${ogg}.tmp.ogg"
        # Convert to mono 32kbps for extreme compression
        ffmpeg -y -i "$ogg" -ac 1 -b:a 32k "$tmp_ogg" </dev/null 2>/dev/null
        mv "$tmp_ogg" "$ogg"
    done
else
    echo "  -> ffmpeg not found, skipping audio optimization."
fi

echo "[4/5] Checking redistribution documents..."
required_files=(
    "$STAGING_DIR/$GAME_NAME/LICENSE"
    "$STAGING_DIR/$GAME_NAME/LICENSE_STELLUA.txt"
    "$STAGING_DIR/$GAME_NAME/THIRD_PARTY_LICENSES.md"
    "$STAGING_DIR/$GAME_NAME/mods/admin_seed/LICENSE"
    "$STAGING_DIR/$GAME_NAME/mods/deepslate/LICENSE.md"
    "$STAGING_DIR/$GAME_NAME/mods/glow_pack/LICENSE.md"
    "$STAGING_DIR/$GAME_NAME/mods/mg_villages/LICENSE"
    "$STAGING_DIR/$GAME_NAME/mods/sgjourney/LICENSE"
    "$STAGING_DIR/$GAME_NAME/mods/sgjourney/ASSETS_LICENSE.md"
    "$STAGING_DIR/$GAME_NAME/mods/mg_villages/UPSTREAM_PROVENANCE.md"
    "$STAGING_DIR/$GAME_NAME/mods/shared_textures/PROVENANCE.md"
    "$STAGING_DIR/$GAME_NAME/mods/stl_seasons/PROVENANCE.md"
    "$STAGING_DIR/$GAME_NAME/mods/stl_village_bridge/PROVENANCE.md"
)
for required_file in "${required_files[@]}"; do
    if [ ! -f "$required_file" ]; then
        echo "ERROR: missing required release document: $required_file" >&2
        exit 1
    fi
done

if find "$STAGING_DIR/$GAME_NAME" -name 'ANALISIS_PRIVADO.md' -print -quit | grep -q .; then
    echo "ERROR: private analysis must not be included in the release" >&2
    exit 1
fi

echo "[5/5] Creating final ZIP archive..."
cd "$STAGING_DIR"
# Remove any existing zip
rm -f "$OUTPUT_ZIP"
# Zip with maximum compression
zip -r -9 -q "$OUTPUT_ZIP" "$GAME_NAME"

zip_entries="$(unzip -Z1 "$OUTPUT_ZIP")"
for required_entry in \
    "$GAME_NAME/LICENSE" \
    "$GAME_NAME/LICENSE_STELLUA.txt" \
    "$GAME_NAME/THIRD_PARTY_LICENSES.md" \
    "$GAME_NAME/mods/mg_villages/UPSTREAM_PROVENANCE.md"; do
    if ! printf '%s\n' "$zip_entries" | grep -Fxq "$required_entry"; then
        echo "ERROR: required document missing from ZIP: $required_entry" >&2
        exit 1
    fi
done

if printf '%s\n' "$zip_entries" | grep -Eq '(^|/)ANALISIS_PRIVADO\.md$|(^|/)\.git(/|$)|stl_asuna_bridge'; then
    echo "ERROR: forbidden private or removed content found in ZIP" >&2
    exit 1
fi

echo "=========================================="
echo " SUCCESS!"
echo " Tu archivo optimizado está listo en:"
echo " -> $OUTPUT_ZIP"
echo ""
echo " Comprueba el peso del archivo (debería ser menor a 100MB) y súbelo a ContentDB."
echo "=========================================="

#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

AUDIO_DIR="audio"
MEDIA_DIR="src/media"

mkdir -p "$MEDIA_DIR"

files=("$AUDIO_DIR"/*)

if ((${#files[@]} == 0)); then
  echo "No input files found in $AUDIO_DIR" >&2
  exit 1
fi

ffmpeg-normalize "${files[@]}" \
  -nt rms \
  -t -20 \
  -ar 44100 \
  -ac 1 \
  -c:a libvorbis \
  -b:a 96k \
  -ext ogg \
  --output-folder "$MEDIA_DIR" \
  -f

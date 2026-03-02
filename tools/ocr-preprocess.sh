#!/bin/bash
# ocr-preprocess.sh — Prepare scanned images for OCR using ImageMagick
# The purpose of this script is to help OCR systems better understand and parse 
# the Bill Gates PDF document, which can be challenging due to its age and 
# printer quality. It uses ImageMagick to clean up and sharpen the raw image 
# extracted from the original PDF.
#
# Usage: ./ocr-preprocess.sh input.jpg [output.png]
#
# Pipeline steps:
#   1. Grayscale       — strip color noise, reduce data
#   2. Deskew          — auto-correct page tilt (up to 40°)
#   3. Normalize       — stretch histogram to full 0–255 range
#   4. Contrast stretch— clip 3% darkest/lightest pixels for better range
#   5. Unsharp mask    — sharpen character edges before thresholding
#   6. Threshold 50%   — binarize to pure black & white

INPUT="$1"
OUTPUT="${2:-${INPUT%.*}-ocr-ready.png}"

if [ -z "$INPUT" ]; then
  echo "Usage: $0 input.jpg [output.png]"
  exit 1
fi

echo "Processing: $INPUT -> $OUTPUT"

magick "$INPUT" \
  -colorspace Gray \
  -deskew 40% \
  -resize 200% \
  -unsharp 0x1+1+0.05 \
  "$OUTPUT"

echo "Done: $OUTPUT"

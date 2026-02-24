#!/bin/bash
# Patches the printing plugin's native Windows code to disable text anti-aliasing.
# This is required for sharp text output on thermal printers (1-bit / black-white only).
#
# Run this after `flutter pub get` to re-apply the patch:
#   bash scripts/patch_printing.sh

PRINT_JOB_CPP="$HOME/.pub-cache/hosted/pub.dev/printing-5.14.2/windows/print_job.cpp"

if [ ! -f "$PRINT_JOB_CPP" ]; then
  echo "ERROR: print_job.cpp not found at $PRINT_JOB_CPP"
  echo "Check if the printing package version has changed."
  exit 1
fi

# Check if already patched
if grep -q "FPDF_RENDER_NO_SMOOTHTEXT" "$PRINT_JOB_CPP"; then
  echo "Already patched — FPDF_RENDER_NO_SMOOTHTEXT is present."
  exit 0
fi

# Apply the patch: add FPDF_RENDER_NO_SMOOTHTEXT to the render flags
sed -i.bak 's/FPDF_ANNOT | FPDF_PRINTING)/FPDF_ANNOT | FPDF_PRINTING | FPDF_RENDER_NO_SMOOTHTEXT)/' "$PRINT_JOB_CPP"

if grep -q "FPDF_RENDER_NO_SMOOTHTEXT" "$PRINT_JOB_CPP"; then
  echo "SUCCESS: Patched print_job.cpp with FPDF_RENDER_NO_SMOOTHTEXT"
  rm -f "${PRINT_JOB_CPP}.bak"
else
  echo "ERROR: Patch failed. Restoring backup."
  mv "${PRINT_JOB_CPP}.bak" "$PRINT_JOB_CPP"
  exit 1
fi

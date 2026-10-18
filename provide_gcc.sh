#!/usr/bin/env bash
set -euo pipefail

# Arm GNU Toolchain 14.2.Rel1, shared with the firmware CI toolchain version.
URL="https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz"
TMP_DIR="/tmp/tunuino-provide_gcc14"
archive="${URL##*/}"
mkdir -p "$TMP_DIR"
if ! compgen -G "$TMP_DIR/arm-gnu-toolchain-*/bin/arm-none-eabi-gcc" >/dev/null; then
  curl --fail --location --retry 3 --output "$TMP_DIR/$archive" "$URL"
  tar -xJf "$TMP_DIR/$archive" -C "$TMP_DIR"
  rm -f "$TMP_DIR/$archive"
fi
shopt -s nullglob
bins=("$TMP_DIR"/arm-gnu-toolchain-*/bin/arm-none-eabi-*)
if (( ${#bins[@]} == 0 )); then
  echo "Arm GNU Toolchain extraction failed" >&2
  exit 1
fi
for bin in "${bins[@]}"; do
  ln -sf "$bin" "/usr/local/bin/$(basename "$bin")"
done
/usr/local/bin/arm-none-eabi-gcc --version

#!/usr/bin/env bash

set -e
set -o pipefail

POPPLER_VERSION=24.08.0
POPPLER_DATA_URL="https://poppler.freedesktop.org/poppler-data-0.4.12.tar.gz"
BUILD="0"

# Conda environment path
ENV_LIB_PATH="/c/Miniconda/envs/test/Library"

# Create working directory
mkdir "poppler-$POPPLER_VERSION"
cd "poppler-$POPPLER_VERSION" || exit 1

# Copy the full Library directory (includes bin, include, lib, share)
cp -a "$ENV_LIB_PATH" .

# Download and install poppler-data
mkdir -p share/poppler
cd share || exit 1
curl -sSL "$POPPLER_DATA_URL" -o poppler-data.tar.gz
tar xvzf poppler-data.tar.gz -C poppler --strip-components 1
rm poppler-data.tar.gz
cd ..

# Set output for GitHub Actions
echo "POPPLER_VERSION=$POPPLER_VERSION" >> "$GITHUB_ENV"
echo "BUILD=$BUILD" >> "$GITHUB_ENV"

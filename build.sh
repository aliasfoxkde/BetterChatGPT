#!/bin/bash

# Build script for Cloudflare Pages
# This script handles Yarn version compatibility issues

set -e

echo "Starting build process..."
echo "Node version: $(node --version)"
echo "Yarn version: $(yarn --version)"

# Check if we're using Yarn 3.x and have a v1 lockfile
if yarn --version | grep -q "^3\." && head -n 2 yarn.lock | grep -q "yarn lockfile v1"; then
    echo "Detected Yarn 3.x with v1 lockfile. Installing with compatibility mode..."
    
    # Use npm instead to avoid lockfile format conflicts
    echo "Using npm for installation to avoid lockfile conflicts..."
    npm install --frozen-lockfile
    
    # Build with npm
    echo "Building with npm..."
    npm run build
else
    echo "Using yarn for installation and build..."
    # Use yarn normally
    yarn install --frozen-lockfile
    yarn build
fi

echo "Build completed successfully!"

#!/bin/bash

# Script to generate package-lock.json from yarn.lock
# This provides a fallback option for npm-based builds

echo "Generating package-lock.json from existing dependencies..."

# Remove existing package-lock.json if it exists
rm -f package-lock.json

# Remove node_modules to ensure clean install
rm -rf node_modules

# Install with npm to generate package-lock.json
npm install

echo "package-lock.json generated successfully!"
echo "You can now use 'npm ci && npm run build' as the build command in Cloudflare Pages."

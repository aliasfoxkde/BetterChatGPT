# Cloudflare Pages Build Configuration

## Issue
The deployment fails because Cloudflare Pages uses Yarn 3.6.3 but the project has a Yarn v1 lockfile, causing a format incompatibility error: "The lockfile would have been modified by this install, which is explicitly forbidden" (YN0028).

## Solution
This project now includes multiple approaches to resolve the Yarn lockfile compatibility issue:

### 1. Package Manager Specification
- Added `packageManager: "yarn@1.22.19"` to package.json
- Added `engines` field specifying Node.js and Yarn versions
- Created `.nvmrc` file to specify Node.js version

### 2. Build Script Alternative
- Created `build.sh` script that detects Yarn version conflicts
- Falls back to npm when Yarn 3.x conflicts with v1 lockfile
- Can be used as custom build command in Cloudflare Pages

### 3. Yarn Configuration
- Added `.yarnrc` file for Yarn v1 compatibility settings

## Cloudflare Pages Configuration

### Recommended Solution: Set Environment Variables
In your Cloudflare Pages dashboard:

1. Go to your project settings
2. Navigate to "Environment variables"
3. Add the following variables for **Production** and **Preview** environments:
   - `NODE_VERSION`: `18.17.1`
   - `YARN_VERSION`: `1.22.19`

This forces Cloudflare Pages to use Yarn 1.22.19 instead of the default Yarn 3.6.3, which is compatible with the existing v1 lockfile format.

### Alternative Options

#### Option 1: Use Custom Build Command
Set the build command in Cloudflare Pages to:
```bash
./build.sh
```

#### Option 2: Use npm Instead
If Yarn version forcing doesn't work, set the build command to:
```bash
npm ci && npm run build
```
Note: This requires generating a package-lock.json file first.

#### Option 3: Migrate to Yarn 3.x (Advanced)
Upgrade the entire project to use Yarn 3.x and regenerate the lockfile:
```bash
yarn set version stable
yarn install
```

## Step-by-Step Fix Instructions

1. **Set Environment Variables** (Recommended):
   - In Cloudflare Pages dashboard → Settings → Environment variables
   - Add `NODE_VERSION=18.17.1` and `YARN_VERSION=1.22.19`
   - Redeploy the project

2. **If environment variables don't work**:
   - Change build command to `./build.sh`
   - Or change build command to `npm ci && npm run build`

The environment variable approach is the cleanest solution as it maintains the existing project structure while ensuring compatibility.

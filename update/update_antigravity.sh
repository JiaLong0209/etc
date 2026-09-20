#!/bin/bash

# --- Configuration ---
# Add your repository URL here
REPO_URL="https://aur.archlinux.org/antigravity.git"
BUILD_DIR="$HOME/antigravity-build"

# 1. Ensure the directory exists
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR" || exit

echo "Starting Build Process in"
pwd

# 2. Check if it's already a git repo
if [ ! -d ".git" ]; then
    echo "🌐 Directory is not a repo. Initializing clone..."
    # Clone the contents directly into the current folder
    git clone "$REPO_URL" .
else
    echo "📥 Pulling latest changes..."
    git pull
fi

# 3. Build and Install
echo "🛠 Rebuilding and installing..."
makepkg -si --noconfirm

echo "🚀 Antigravity IDE is now up to date."
echo "You can launch it using $BUILD_DIR/src/antigravity.sh"


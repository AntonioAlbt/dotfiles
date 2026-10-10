#!/usr/bin/env bash
set -e

# Get the absolute path to the directory containing this script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up dotfiles from $DOTFILES_DIR..."

# Function to safely create symlinks
link_file() {
    local src="$1"
    local dest="$2"

    # Check if the destination exists and is not a symlink
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up existing file: $dest -> ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi

    # Create the symlink
    echo "Linking $src -> $dest"
    ln -sf "$src" "$dest"
}

# Link standard dotfiles in the home directory
for file in .bashrc .aliases .profile .zshrc .p10k.zsh .vimrc .tmux.conf .gitconfig; do
    if [ -f "$DOTFILES_DIR/$file" ]; then
        link_file "$DOTFILES_DIR/$file" "$HOME/$file"
    fi
done

# Link config directories
mkdir -p "$HOME/.config"
if [ -d "$DOTFILES_DIR/btop" ]; then
    link_file "$DOTFILES_DIR/btop" "$HOME/.config/btop"
fi

echo "Done! Dotfiles have been successfully symlinked."

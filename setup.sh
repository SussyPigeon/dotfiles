it#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
PACKAGES=("neovim" "lazygit" "eza")

install_packages() {
    echo "Installing packages . . ."
    
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing . . ."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        exit 1
    fi
    brew update
    brew install "${PACKAGES[@]}"
}

###
## MAIN
###

install_packages
cd "$DOTFILES_DIR" || exit
stow .
echo "Dotfiles setup complete!"

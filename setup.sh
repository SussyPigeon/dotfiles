#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
PACKAGES=("neovim" "lazygit" "eza")

install_packages() {
    echo "Installing packages . . ."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update
        sudo apt install -y "${PACKAGES[@]}"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command -v brew &> /dev/null; then
            echo "Homebrew not found. Installing . . ."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install "${PACKAGES[@]}"
    else
        echo "Unsupported OS."
        exit 1
    fi
}

###
## MAIN
###

install_packages
cd "$DOTFILES_DIR" || exit
stow .
echo "Dotfiles setup complete!"

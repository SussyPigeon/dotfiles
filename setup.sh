#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

if [[ "$OSTYPE" == "darwin"* ]]; then
    OS_TYPE="macos"
    PACKAGES=("neovim" "lazygit" "eza" "stow")
    PACKAGE_MANAGER="brew"
elif [[ -n "$WSL_DISTRO_NAME" ]] || grep -qi microsoft /proc/version 2>/dev/null; then
    OS_TYPE="wsl"
    PACKAGES=("neovim" "stow" "zsh")
    PACKAGE_MANAGER="apt"
else
    OS_TYPE="linux"
    PACKAGES=("neovim" "stow" "zsh")
    PACKAGE_MANAGER="apt"
fi

install_packages() {
    echo "Installing packages on $OS_TYPE . . ."

    if [[ "$OS_TYPE" == "macos" ]]; then
        if ! command -v brew &> /dev/null; then
            echo "Homebrew not found. Installing..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew update
        brew install "${PACKAGES[@]}"
    else
        sudo apt update
        sudo apt install -y "${PACKAGES[@]}"
    fi
}

install_ohmyzsh() {
	echo "Installing Oh-My-Zsh . . ."

	if ! [ -e ~/.oh-my-zsh/ ]; then 
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	fi

    ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && \
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>/dev/null || true
    
    [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && \
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>/dev/null || true
    
    [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && \
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" 2>/dev/null || true
}

deploy_dotfiles() {
    echo "Deploying dotfiles using GNU Stow . . ."
    
    mkdir -p ~/dotfiles_backup
    for file in .zshrc .p10k.zsh; do
        if [ -f ~/$file ] && [ ! -L ~/$file ]; then
            echo "Backing up ~/$file..."
            mv ~/$file ~/dotfiles_backup/
        fi
    done
    
    # Run stow for each directory in the dotfiles repo
    # Excluding the wsl directory which is handled separately
    cd "$DOTFILES_DIR" || exit
    for dir in */; do
        dir=${dir%/}  # Remove trailing slash
        if [ "$dir" != "wsl" ]; then
            echo "Stowing $dir..."
            stow -v "$dir"
        fi
    done
}

###
## MAIN
###

echo "Starting dotfiles setup for $OS_TYPE . . ."
install_packages
install_ohmyzsh
deploy_dotfiles

echo "Dotfiles setup complete! Please restart your shell or run 'source ~/.zshrc'"

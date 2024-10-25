#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"
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

install_ohmyzsh() {
	echo "Installing Oh-My-Zsh . . ."

	if ! [ -e ~/.oh-my-zsh/ ]; then 
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

	if [ -e ~/.zshrc ]; then
		rm ~/.zshrc
	fi
}

###
## MAIN
###

install_packages
install_ohmyzsh
cd "$DOTFILES_DIR" || exit
stow .
echo "Dotfiles setup complete!"

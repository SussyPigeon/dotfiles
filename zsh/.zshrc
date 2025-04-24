# Enable Powerlevel10k instant promt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Oh-My-Zsh plugins
plugins=(
	git
	z
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Source configs
for config_file (~/.config/zsh/common/*zsh); do
    source $config_file
done

case "$OSTYPE" in
    darwin*) source ~/.config/zsh/os/macos.zsh ;;
    linux*) source ~/.config/zsh/os/wsl.zsh ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
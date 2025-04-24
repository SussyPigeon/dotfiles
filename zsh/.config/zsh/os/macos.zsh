export PATH=$PATH:/Users/asol/.spicetify

# setting up Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/asol/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/asol/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/asol/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/asol/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
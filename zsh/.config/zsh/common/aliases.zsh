alias cls='clear'
alias vi='nvim'
alias vim='nvim'
alias lg='lazygit'

if command -v eza &> /dev/null; then
    alias ls='eza --icons --color=always --group-directories-first'
    alias ll='eza -alF --icons --color=always --group-directories-first'
    alias la='eza -a --icons --color=always --group-directories-first'
    alias l='eza -F --icons --color=always --group-directories-first'
    alias l.='eza -a | egrep "^\."'
fi

alias py='python3'
alias pip='pip3'
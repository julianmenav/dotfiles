# Oh My Zsh (cloned on first start if missing, plugins too)
export ZSH="$HOME/.oh-my-zsh"
[[ -d "$ZSH" ]] || git clone -q --depth 1 https://github.com/ohmyzsh/ohmyzsh "$ZSH"
for _p in zsh-autosuggestions zsh-syntax-highlighting; do
    [[ -d "$ZSH/custom/plugins/$_p" ]] || git clone -q --depth 1 "https://github.com/zsh-users/$_p" "$ZSH/custom/plugins/$_p"
done
unset _p
ZSH_THEME="robbyrussell"
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export VISUAL='nvim'


# Starship
command -v starship >/dev/null && eval "$(starship init zsh)"


# Zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"


# fzf keybindings
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh


# Aliases
command -v bat >/dev/null && alias cat=bat


# New kitty window in the current directory
kt() { kitty . &>/dev/null & disown; }


# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"


# nvm (installed via pacman)
[[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh


# ssh-agent, keys expire after 2h
[[ -d ~/.ssh ]] || mkdir -m 700 ~/.ssh
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 7200 > ~/.ssh/ssh-agent.env
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source ~/.ssh/ssh-agent.env > /dev/null
fi


# Commands starting with a space are not saved to history
setopt HIST_IGNORE_SPACE


# git-wt
eval "$(git wt --init zsh 2>/dev/null)"


# uv installer env (prepends ~/.local/bin to PATH)
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"


# Per-machine config (host-* package)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

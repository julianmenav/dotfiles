# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
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


# Ghost-type Pokémon on a new terminal (pokemon-colorscripts); silent if not installed
if [[ -o interactive ]] && command -v pokemon-colorscripts >/dev/null; then
    typeset -a _ghosts=(gastly haunter gengar misdreavus shuppet banette duskull dusclops sableye drifloon
                      drifblim mismagius dusknoir spiritomb froslass rotom giratina yamask cofagrigus
                      frillish jellicent litwick lampent chandelure golett golurk honedge doublade
                      aegislash phantump trevenant pumpkaboo gourgeist hoopa decidueye sandygast palossand
                      mimikyu dhelmise marshadow lunala blacephalon sinistea polteageist runerigus dreepy
                      drakloak dragapult spectrier)
    pokemon-colorscripts --no-title -n "${_ghosts[RANDOM % ${#_ghosts[@]} + 1]}"
    unset _ghosts
fi


# Per-machine config (host-* package)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

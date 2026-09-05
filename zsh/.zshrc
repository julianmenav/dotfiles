# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='nvim'
export VISUAL='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#Starship
command -v starship >/dev/null && eval "$(starship init zsh)"


#Zoxide
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"


# FZF keybindings
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh


# ALIASES
command -v bat >/dev/null && alias cat=bat


# Open a new Kitty terminal window in the current directory
# Runs in background with output suppressed, and disowns the process
# so it continues running even if the parent shell is closed
kt() { kitty . &>/dev/null & disown; }


# PATH
export PATH="$HOME/.local/bin:$PATH"   # precommit, pipx, ...
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"


# nvm (installed via pacman)
[[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh


# ssh-agent with 2-hour key timeout
[[ -d ~/.ssh ]] || mkdir -m 700 ~/.ssh
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 7200 > ~/.ssh/ssh-agent.env
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source ~/.ssh/ssh-agent.env > /dev/null
fi


# To be able to prevent zsh history from saving commands (for passwords for example)
setopt HIST_IGNORE_SPACE


# git-wt (no-op when the subcommand is not installed)
eval "$(git wt --init zsh 2>/dev/null)"


# A random *ghost-type* Pokémon on a new terminal (pacman -S pokemon-colorscripts-git); silent if missing.
# Same tool HyDE uses. Names validated against the tool's list (gens 1-8). Use -r instead of -n for any Pokémon.
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


# Per-machine config: work tools, aliases, PATHs.
# ~/.zshrc.local comes from the host-home / host-work stow package; stow exactly one of them.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

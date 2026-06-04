# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -o interactive && -t 0 && -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
if [[ -o interactive && -t 0 ]]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME=""
fi


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
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

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

# Keep PATH stable and unique. `path` is zsh's array view of PATH.
typeset -U path PATH

path_prepend() {
  [[ -d "$1" ]] && path=("$1" $path)
}

path_append() {
  [[ -d "$1" ]] && path=($path "$1")
}

path_prune_missing() {
  local -a existing_path=()
  local dir

  for dir in $path; do
    [[ -d "$dir" ]] && existing_path+=("$dir")
  done

  path=("${existing_path[@]}")
}

if [[ -x /opt/homebrew/bin/brew ]] && (( ! $+commands[brew] )); then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export BUN_INSTALL="$HOME/.bun"
export NVM_DIR="$HOME/.nvm"
path_prepend "$HOME/.local/bin"
path_prepend "$BUN_INSTALL/bin"
path_prepend "$HOME/.opencode/bin"
path_prepend "/opt/homebrew/opt/curl/bin"
path_prepend "/opt/homebrew/opt/openjdk/bin"
path_prepend "/opt/homebrew/opt/libpq/bin"
path_append "$HOME/.local/share/nvim/mason/bin"
path_append "/usr/local/mysql/bin"
path_append "$HOME/.lmstudio/bin"

path_prune_missing

unfunction path_prepend path_append path_prune_missing

if (( $+commands[nvim] )); then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export GIT_EDITOR="nvim"
fi

# bun completions
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# nvm is useful but expensive to load on every new terminal. Load it on demand.
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  nvm() {
    unfunction nvm
    source "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
    nvm "$@"
  }

  for _nvm_cmd in node npm npx corepack; do
    if ! (( $+commands[$_nvm_cmd] )); then
      eval "${_nvm_cmd}() { unfunction node npm npx corepack 2>/dev/null; source \"\$NVM_DIR/nvm.sh\"; [[ -s \"\$NVM_DIR/bash_completion\" ]] && source \"\$NVM_DIR/bash_completion\"; ${_nvm_cmd} \"\$@\"; }"
    fi
  done
  unset _nvm_cmd
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [[ -o interactive && -t 0 && -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi

if [[ -o interactive && -t 0 && -e "$HOME/.iterm2_shell_integration.zsh" ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

alias idea='open -a "IntelliJ IDEA.app"'
alias xcode='open -a Xcode.app'
alias sublime='open -a "Sublime Text.app"'

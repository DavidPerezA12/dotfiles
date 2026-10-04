# Powerlevel10k startup guard. Keep this close to the top of ~/.zshrc so prompt
# behavior is decided before Oh My Zsh or version managers can change it.
_dotfiles_has_terminal() {
  [[ -t 0 || -t 1 || -t 2 || -n "${DOTFILES_FORCE_TERMINAL:-}" ]]
}

if [[ "${_DOTFILES_ZSHRC_LOADED_PID:-}" == "$$" ]] &&
   { [[ -n "${ZSH_THEME:-}" ]] || (( $+functions[p10k] )) || ! _dotfiles_has_terminal; }; then
  return
fi
typeset -g _DOTFILES_ZSHRC_LOADED_PID="$$"

# Instant prompt stays off. It replays a cached prompt frame before zshrc
# finishes, and a stale cache makes iTerm open with a layout that then jumps.
# The cache under ~/.cache/p10k-instant-prompt-* is never sourced.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Oh My Zsh. Load Powerlevel10k only when a real terminal is attached; scripts
# and editors that start zsh non-interactively get a plain, theme-less shell.
export ZSH="$HOME/.oh-my-zsh"

if [[ -o interactive ]] && _dotfiles_has_terminal; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME=""
fi

# Skip untracked files in the prompt's dirty check; large repos stay fast.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

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
path_prepend "/opt/homebrew/opt/curl/bin"
path_prepend "/opt/homebrew/opt/openjdk/bin"
path_prepend "/opt/homebrew/opt/libpq/bin"
path_append "$HOME/.local/share/nvim/mason/bin"

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
if [[ -o interactive ]] && _dotfiles_has_terminal && [[ -f ~/.p10k.zsh ]]; then
  source ~/.p10k.zsh
fi

unfunction _dotfiles_has_terminal

alias xcode='open -a Xcode.app'

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<
# claude-yolo: ejecuta Claude Code sin pedir permisos
alias claude-yolo='claude --dangerously-skip-permissions'

# iTerm2 shell integration. Needed for Cmd+D / Cmd+T to reuse the current
# directory (OSC 7), semantic marks and other profile features.
if [[ -o interactive && -s "$HOME/.iterm2_shell_integration.zsh" ]]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

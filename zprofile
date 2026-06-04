if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

typeset -U path PATH

[[ -d /opt/homebrew/opt/libpq/bin ]] && path=("/opt/homebrew/opt/libpq/bin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

if [[ -o interactive && "${_DOTFILES_ZSHRC_LOADED_PID:-}" != "$$" && -r "$HOME/.zshrc" ]]; then
  _dotfiles_parent_comm="$(ps -p "$PPID" -o comm= 2>/dev/null)"

  if [[ "${TERM_PROGRAM:-}" == "iTerm.app" && "${_dotfiles_parent_comm:t}" == "login" ]]; then
    DOTFILES_FORCE_TERMINAL=1
    source "$HOME/.zshrc"
    unset DOTFILES_FORCE_TERMINAL
  else
    source "$HOME/.zshrc"
  fi

  unset _dotfiles_parent_comm
fi

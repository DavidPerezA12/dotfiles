# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
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
ZSH_THEME="powerlevel10k/powerlevel10k"


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
plugins=(git zsh-autosuggestions zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias idea='open -a "IntelliJ IDEA.app"'
alias xcode='open -a Xcode.app'
alias sublime='open -a "Sublime Text.app"'


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


export PATH=$PATH:/usr/local/mysql/bin


 
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/david/.lmstudio/bin"
# End of LM Studio CLI section


export OPENROUTER_API_KEY="REMOVED_OPENROUTER_KEY"



# ═══════════════════════════════════════════════════════════════
# FUNCIONES DE IA CON OPENROUTER
# ═══════════════════════════════════════════════════════════════
# 
# ia "<prompt>"        -> Pregunta directa a la IA con streaming
# ia --solo "<prompt>" -> Respuesta sin streaming (más rápido)
# ia-rules             -> Muestra las reglas del sistema actuales
# ia-rules "<nuevas>"  -> Cambia las reglas del sistema
# ia-rules --reset     -> Restaura las reglas por defecto
#
# Ejemplos:
#   ia "cómo buscar archivos por fecha"
#   ia --solo "comando para ver procesos"
#   ia-rules "Responde siempre con ejemplos de código"

# Dependencias: curl; jq opcional para decodificar JSON durante el streaming
# Requiere: variable de entorno OPENROUTER_API_KEY ya definida más arriba

# Reglas de estilo por defecto. Deja IA_SYSTEM_RULES vacía para desactivar.
: ${IA_SYSTEM_RULES:="Eres un asistente de terminal EXTREMADAMENTE CONCISO. Tu objetivo es dar la respuesta MÁS CORTA posible.

REGLAS ESTRICTAS:
1. Para comandos: SOLO el bloque de código. Cero texto adicional.
2. NUNCA des alternativas
3. NUNCA expliques qué hace cada parte
4. NUNCA des notas o advertencias adicionales
5. NUNCA repitas la pregunta del usuario
6. Máximo 3 líneas de respuesta en total
7. Responde en español
8. Para las recomendaciones, uso macOS

FORMATO OBLIGATORIO:
\`\`\`bash
comando_aqui
\`\`\`

Si es muy complejo, máximo 1 línea antes del código."}

# Escapa un string para JSON (portable en macOS)
_json_escape() {
  # Reemplaza barras, comillas dobles y codifica saltos de línea como \n
  printf '%s' "$1" | awk 'BEGIN{ORS="";} {gsub(/\\/,"\\\\"); gsub(/\"/,"\\\""); if(NR>1) printf "\\n"; printf "%s",$0}'
}

# Envía la petición a OpenRouter con streaming y pinta los tokens
_or_post_stream() {
  local json_payload="$1"
  if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "Falta OPENROUTER_API_KEY" >&2
    return 1
  fi

  echo ""
  if command -v jq >/dev/null 2>&1; then
    curl -sS -N https://openrouter.ai/api/v1/chat/completions \
      -H "Authorization: Bearer $OPENROUTER_API_KEY" \
      -H "Content-Type: application/json" \
      -d "$json_payload" 2>/dev/null \
    | awk '
      /^data: / {
        sub(/^data: /, "");
        if ($0 == "[DONE]") next;
        print;
        fflush();
      }
    ' \
    | jq -jr --unbuffered '.choices[0].delta.content // empty' 2>/dev/null
  else
    curl -sS -N https://openrouter.ai/api/v1/chat/completions \
      -H "Authorization: Bearer $OPENROUTER_API_KEY" \
      -H "Content-Type: application/json" \
      -d "$json_payload" 2>/dev/null \
    | awk '
      /^data: / {
        sub(/^data: /, "");
        if ($0 == "[DONE]") next;
        if (match($0, /"content":"([^"]*)"/, arr)) {
          gsub(/\\n/, "\n", arr[1]);
          gsub(/\\t/, "\t", arr[1]);
          gsub(/\\"/, "\"", arr[1]);
          gsub(/\\\\/, "\\", arr[1]);
          printf "%s", arr[1];
          fflush();
        }
      }
    '
  fi
  echo -e "\n"
}

_or_post_once() {
  local json_payload="$1"
  if [ -z "$OPENROUTER_API_KEY" ]; then
    echo "Falta OPENROUTER_API_KEY" >&2
    return 1
  fi
  if command -v jq >/dev/null 2>&1; then
    curl -sS https://openrouter.ai/api/v1/chat/completions \
      -H "Authorization: Bearer $OPENROUTER_API_KEY" \
      -H "Content-Type: application/json" \
      -d "$json_payload" \
    | jq -r '.choices[0].message.content // empty'
  else
    curl -sS https://openrouter.ai/api/v1/chat/completions \
      -H "Authorization: Bearer $OPENROUTER_API_KEY" \
      -H "Content-Type: application/json" \
      -d "$json_payload" \
    | sed -n 's/.*"content":"\([^"]*\)".*/\1/p' \
    | sed 's/\\n/\n/g; s/\\t/\t/g; s/\\\"/\"/g; s/\\\\/\\/g'
  fi
}

_solo_sanitize() {
  # Sanitización suave: solo quita espacios extra al inicio/final de cada línea
  # pero mantiene el formato markdown y saltos de línea
  sed -e 's/^[[:space:]]\+//; s/[[:space:]]\+$//'
}

ia() {
  if [ $# -eq 0 ]; then
    echo 'Uso: ia "<prompt>"'
    return 1
  fi
  local solo=0
  if [ "$1" = "--solo" ] || [ "$1" = "-c" ]; then
    solo=1
    shift
  fi
  
  # Añade contexto del sistema automáticamente
  local os_name="$(uname -s)"
  local shell_name="zsh"
  local sys_context="[Sistema: $os_name, Shell: $shell_name]"
  
  local prompt="$sys_context $*"
  local escaped
  escaped="$(_json_escape "$prompt")"
  local sys_escaped
  sys_escaped="$(_json_escape "$IA_SYSTEM_RULES")"
  local payload
  if [ $solo -eq 1 ]; then
    if [ -n "$IA_SYSTEM_RULES" ]; then
      payload='{"model":"google/gemini-2.0-flash-exp:free","temperature":0.7,"max_tokens":2000,"messages":[{"role":"system","content":"'"$sys_escaped"'"},{"role":"user","content":"'"$escaped"'"}]}'
    else
      payload='{"model":"google/gemini-2.0-flash-exp:free","temperature":0.7,"max_tokens":2000,"messages":[{"role":"user","content":"'"$escaped"'"}]}'
    fi
    _or_post_once "$payload" | _solo_sanitize
  else
    if [ -n "$IA_SYSTEM_RULES" ]; then
      payload='{"model":"google/gemini-2.0-flash-exp:free","temperature":0.7,"max_tokens":2000,"stream":true,"messages":[{"role":"system","content":"'"$sys_escaped"'"},{"role":"user","content":"'"$escaped"'"}]}'
    else
      payload='{"model":"google/gemini-2.0-flash-exp:free","temperature":0.7,"max_tokens":2000,"stream":true,"messages":[{"role":"user","content":"'"$escaped"'"}]}'
    fi
    _or_post_stream "$payload"
  fi
}

# Muestra o cambia las reglas del sistema de IA
ia-rules() {
  if [ $# -eq 0 ]; then
    echo "=== REGLAS ACTUALES DE IA ==="
    echo "$IA_SYSTEM_RULES"
    echo ""
    echo "Usa: ia-rules \"<nuevas reglas>\" para cambiarlas"
    echo "Usa: ia-rules --reset para restaurar las por defecto"
  elif [ "$1" = "--reset" ]; then
    unset IA_SYSTEM_RULES
    source ~/.zshrc 2>/dev/null || true
    echo "✓ Reglas restauradas a las por defecto"
  else
    export IA_SYSTEM_RULES="$*"
    echo "✓ Reglas actualizadas"
  fi
}


# bun completions
[ -s "/Users/david/.bun/_bun" ] && source "/Users/david/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ═══════════════════════════════════════════════════════════════
# NVM (Node Version Manager)
# ═══════════════════════════════════════════════════════════════
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Aliases útiles para NVM
alias nvm-latest="nvm install node --reinstall-packages-from=current"
alias nvm-lts="nvm install --lts --reinstall-packages-from=current"
alias nvm-list="nvm ls-remote --lts"

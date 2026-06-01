#!/usr/bin/env bash

# ============================================================
# Instalador de Dotfiles para macOS
# Autor: David Perez
# ============================================================

set -euo pipefail

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directorio de dotfiles. Use the checked-out repository, no matter where the
# script is launched from.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backups/$(date +%Y%m%d_%H%M%S)"
RUN_BREW="${RUN_BREW:-1}"
RUN_LAZY_SYNC="${RUN_LAZY_SYNC:-1}"
export HOMEBREW_NO_ENV_HINTS="${HOMEBREW_NO_ENV_HINTS:-1}"
export HOMEBREW_NO_REQUIRE_TAP_TRUST="${HOMEBREW_NO_REQUIRE_TAP_TRUST:-1}"
VERIFY_ONLY=0

# Funciones auxiliares
print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

usage() {
    cat << EOF
Usage: ./install.sh [--verify] [--no-brew] [--no-nvim-sync]

Options:
  --verify        Check expected symlinks and config syntax without installing.
  --no-brew       Skip Homebrew bundle install.
  --no-nvim-sync  Skip lazy.nvim plugin sync.
EOF
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --verify)
            VERIFY_ONLY=1
            shift
            ;;
        --no-brew)
            RUN_BREW=0
            shift
            ;;
        --no-nvim-sync)
            RUN_LAZY_SYNC=0
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

link_dotfile() {
    local source_path="$1"
    local target_path="$2"

    mkdir -p "$(dirname "$target_path")"

    if [ -L "$target_path" ]; then
        local current_target
        current_target="$(readlink "$target_path")"
        if [ "$current_target" = "$source_path" ]; then
            print_success "Already linked: $target_path"
            return
        fi
        mkdir -p "$BACKUP_DIR"
        mv "$target_path" "$BACKUP_DIR/$(basename "$target_path").symlink"
        print_warning "Backed up old symlink: $target_path"
    elif [ -e "$target_path" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target_path" "$BACKUP_DIR/$(basename "$target_path")"
        print_warning "Backed up existing path: $target_path"
    fi

    ln -s "$source_path" "$target_path"
    print_success "Linked: $target_path -> $source_path"
}

verify_link() {
    local source_path="$1"
    local target_path="$2"

    if [ ! -L "$target_path" ]; then
        print_error "Missing symlink: $target_path"
        return 1
    fi

    local current_target
    current_target="$(readlink "$target_path")"
    if [ "$current_target" != "$source_path" ]; then
        print_error "Wrong symlink: $target_path -> $current_target"
        return 1
    fi

    print_success "Verified: $target_path -> $source_path"
}

# Banner
echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════╗
║                                                       ║
║     ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗    ║
║     ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝    ║
║     ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗    ║
║     ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║    ║
║     ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║    ║
║     ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝    ║
║                                                       ║
║               Instalador para macOS                   ║
╚═══════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "Este script solo funciona en macOS"
    exit 1
fi

if [ "$VERIFY_ONLY" = "1" ]; then
    print_info "Verificando dotfiles sin instalar..."
    verify_link "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
    verify_link "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"
    verify_link "$DOTFILES_DIR/p10k.zsh" "$HOME/.p10k.zsh"
    verify_link "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
    zsh -n "$DOTFILES_DIR/zshrc"
    zsh -n "$DOTFILES_DIR/zprofile"
    zsh -n "$DOTFILES_DIR/p10k.zsh"
    if command -v nvim &> /dev/null; then
        nvim --headless "+lua assert(vim.uv.fs_realpath(vim.fn.stdpath('config')) == '$DOTFILES_DIR/config/nvim')" +qa
    fi
    print_success "Verificación completada"
    exit 0
fi

print_info "Iniciando instalación de dotfiles..."
echo ""

# 1. Instalar Homebrew
if ! command -v brew &> /dev/null; then
    print_info "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew instalado"
else
    print_success "Homebrew ya está instalado"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi
echo ""

# 2. Instalar paquetes de Homebrew
if [ "$RUN_BREW" = "1" ]; then
    print_info "Instalando paquetes desde Brewfile..."
    brew bundle --file "$DOTFILES_DIR/Brewfile"
    print_success "Homebrew bundle completado"
else
    print_warning "Saltando Homebrew bundle porque RUN_BREW=0"
fi
echo ""

# 5. Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh instalado"
else
    print_success "Oh My Zsh ya está instalado"
fi
echo ""

# 6. Instalar Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    print_info "Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    print_success "Powerlevel10k instalado"
else
    print_success "Powerlevel10k ya está instalado"
fi
echo ""

# 7. Instalar NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
    print_info "Instalando NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    print_success "NVM instalado"
else
    print_success "NVM ya está instalado"
fi
echo ""

# 8. Instalar plugins de Zsh
print_info "Instalando plugins de Zsh..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    print_success "zsh-autosuggestions instalado"
else
    print_success "zsh-autosuggestions ya está instalado"
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    print_success "zsh-syntax-highlighting instalado"
else
    print_success "zsh-syntax-highlighting ya está instalado"
fi
echo ""

# 9. Crear symlinks
print_info "Creando symlinks..."

# Zsh
link_dotfile "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
link_dotfile "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"

# Powerlevel10k
link_dotfile "$DOTFILES_DIR/p10k.zsh" "$HOME/.p10k.zsh"

# Neovim
link_dotfile "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"

echo ""

# 10. Verificar symlinks
print_info "Verificando symlinks..."
verify_link "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
verify_link "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"
verify_link "$DOTFILES_DIR/p10k.zsh" "$HOME/.p10k.zsh"
verify_link "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
echo ""

# 11. Configurar iTerm2 (opcional)
if [ -d "$DOTFILES_DIR/config/iterm2" ]; then
    print_info "Configurando iTerm2..."
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/config/iterm2"
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
    print_success "iTerm2 configurado"
    echo ""
fi

# 12. Sincronizar plugins de Neovim (opcional)
if [ "$RUN_LAZY_SYNC" = "1" ] && command -v nvim &> /dev/null; then
    print_info "Sincronizando plugins de Neovim..."
    nvim --headless "+Lazy! sync" +qa
    print_success "Plugins de Neovim sincronizados"
elif [ "$RUN_LAZY_SYNC" != "1" ]; then
    print_warning "Saltando Lazy sync porque RUN_LAZY_SYNC=0"
fi
echo ""

# 13. Validaciones finales
print_info "Validando configuración..."
zsh -n "$DOTFILES_DIR/zshrc"
nvim --headless "+lua assert(vim.uv.fs_realpath(vim.fn.stdpath('config')) == '$DOTFILES_DIR/config/nvim')" +qa
print_success "Validación completada"
echo ""

# 14. Finalizar
echo -e "${GREEN}"
cat << "EOF"
╔═══════════════════════════════════════════════════════╗
║                                                       ║
║           ✓ Instalación completada!                   ║
║                                                       ║
╚═══════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

print_info "Próximos pasos:"
echo ""
echo "  1. Reinicia tu terminal o ejecuta: source ~/.zshrc"
echo "  2. Abre iTerm2 y configura la fuente Nerd Font"
echo "  3. Si no te gusta el tema de Powerlevel10k, ejecuta: p10k configure"
echo "  4. Edita siempre el repo: $DOTFILES_DIR"
echo ""

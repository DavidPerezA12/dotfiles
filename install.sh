#!/usr/bin/env bash

# ============================================================
# Instalador de Dotfiles para macOS
# Autor: David Perez
# ============================================================

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directorio de dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Funciones auxiliares
print_success() { echo -e "${GREEN}✓ $1${NC}"; }
print_error() { echo -e "${RED}✗ $1${NC}"; }
print_info() { echo -e "${BLUE}ℹ $1${NC}"; }
print_warning() { echo -e "${YELLOW}⚠ $1${NC}"; }

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

print_info "Iniciando instalación de dotfiles..."
echo ""

# 1. Crear directorio de backup
print_info "Creando directorio de backup..."
mkdir -p "$BACKUP_DIR"
print_success "Backup: $BACKUP_DIR"
echo ""

# 2. Instalar Homebrew
if ! command -v brew &> /dev/null; then
    print_info "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Agregar Homebrew al PATH (Apple Silicon)
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    print_success "Homebrew instalado"
else
    print_success "Homebrew ya está instalado"
fi
echo ""

# 3. Actualizar Homebrew
print_info "Actualizando Homebrew..."
brew update
print_success "Homebrew actualizado"
echo ""

# 4. Instalar herramientas CLI
print_info "Instalando herramientas CLI..."
brew install \
    git \
    neovim \
    ripgrep \
    fd \
    fzf \
    bat \
    eza \
    zoxide \
    tmux \
    tree \
    wget \
    curl \
    jq \
    stow

print_success "Herramientas CLI instaladas"
echo ""

# 5. Instalar aplicaciones con Cask
print_info "Instalando aplicaciones con Homebrew Cask..."
brew install --cask \
    iterm2 \
    font-meslo-lg-nerd-font \
    font-hack-nerd-font

print_success "Aplicaciones instaladas"
echo ""

# 6. Instalar Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_info "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh instalado"
else
    print_success "Oh My Zsh ya está instalado"
fi
echo ""

# 7. Instalar Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    print_info "Instalando Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    print_success "Powerlevel10k instalado"
else
    print_success "Powerlevel10k ya está instalado"
fi
echo ""

# 8. Instalar NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
    print_info "Instalando NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    print_success "NVM instalado"
else
    print_success "NVM ya está instalado"
fi
echo ""

# 9. Instalar plugins de Zsh
print_info "Instalando plugins de Zsh..."

# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    print_success "zsh-autosuggestions instalado"
else
    print_success "zsh-autosuggestions ya está instalado"
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    print_success "zsh-syntax-highlighting instalado"
else
    print_success "zsh-syntax-highlighting ya está instalado"
fi
echo ""

# 10. Backup de archivos existentes
print_info "Haciendo backup de configuraciones existentes..."
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$BACKUP_DIR/.zshrc.backup"
[ -f "$HOME/.p10k.zsh" ] && mv "$HOME/.p10k.zsh" "$BACKUP_DIR/.p10k.zsh.backup"
[ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$BACKUP_DIR/nvim.backup"
print_success "Backup completado"
echo ""

# 11. Crear symlinks
print_info "Creando symlinks..."

# Zsh
ln -sf "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
print_success "Linked: ~/.zshrc"

# Powerlevel10k
ln -sf "$DOTFILES_DIR/p10k.zsh" "$HOME/.p10k.zsh"
print_success "Linked: ~/.p10k.zsh"

# Neovim
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
print_success "Linked: ~/.config/nvim"

echo ""

# 12. Configurar iTerm2 (opcional)
if [ -d "$DOTFILES_DIR/config/iterm2" ]; then
    print_info "Configurando iTerm2..."
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/config/iterm2"
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
    print_success "iTerm2 configurado"
    echo ""
fi

# 13. Instalar fzf key bindings
print_info "Configurando fzf..."
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
print_success "fzf configurado"
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
echo "  4. Abre Neovim para instalar plugins automáticamente"
echo ""
print_warning "Backup guardado en: $BACKUP_DIR"
echo ""

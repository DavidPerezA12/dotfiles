# 🍎 Guía de Configuración de macOS

Configuración completa del sistema operativo macOS para desarrollo.

## 📑 Tabla de Contenidos

- [Configuración Inicial](#configuración-inicial)
- [Homebrew Setup](#homebrew-setup)
- [macOS Defaults](#macos-defaults)
- [Apps Esenciales](#apps-esenciales)
- [Herramientas de Desarrollo](#herramientas-de-desarrollo)
- [Troubleshooting](#troubleshooting)

---

## 🚀 Configuración Inicial

### 1. Actualizar macOS

```bash
softwareupdate -l                # Listar actualizaciones
softwareupdate -ia               # Instalar todas
```

### 2. Instalar Xcode Command Line Tools

```bash
xcode-select --install
```

### 3. Configurar Git

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
git config --global init.defaultBranch main
```

---

## 🍺 Homebrew Setup

### Instalación

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Agregar a PATH (Apple Silicon)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Comandos Útiles

```bash
brew update                      # Actualizar Homebrew
brew upgrade                     # Actualizar paquetes
brew outdated                    # Ver desactualizados
brew cleanup                     # Limpiar versiones antiguas
brew doctor                      # Diagnosticar problemas
brew list                        # Lista de instalados
brew search <nombre>             # Buscar paquete
brew info <nombre>               # Info del paquete
```

---

## ⚙️ macOS Defaults

### Sistema

```bash
# Mostrar archivos ocultos en Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Mostrar extensiones de archivo
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Evitar crear archivos .DS_Store en redes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Desactivar advertencia al cambiar extensión
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Mostrar path bar en Finder
defaults write com.apple.finder ShowPathbar -bool true

# Mostrar status bar en Finder
defaults write com.apple.finder ShowStatusBar -bool true
```

### Dock

```bash
# Auto-hide Dock
defaults write com.apple.dock autohide -bool true

# Tiempo de animación del Dock
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Remover delay del auto-hide
defaults write com.apple.dock autohide-delay -float 0

# Tamaño del Dock
defaults write com.apple.dock tilesize -int 48

# Reiniciar Dock
killall Dock
```

### Screenshots

```bash
# Cambiar ubicación de screenshots
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

# Formato de screenshots (png, jpg, pdf)
defaults write com.apple.screencapture type -string "png"

# Desactivar sombra en screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Reiniciar servicio
killall SystemUIServer
```

### Teclado

```bash
# Repetición de tecla rápida
defaults write NSGlobalDomain KeyRepeat -int 2

# Delay corto antes de repetir
defaults write NSGlobalDomain InitialKeyRepeat -int 15
```

### Aplicar Cambios

```bash
# Reiniciar Finder
killall Finder

# Reiniciar Dock
killall Dock

# Reiniciar SystemUIServer
killall SystemUIServer
```

---

## 📱 Apps Esenciales

Ver [README.md - Apps que Uso](../README.md#-apps-que-uso)

---

## 🛠️ Herramientas de Desarrollo

### Lenguajes y Runtimes

```bash
# Node.js (via nvm recomendado)
brew install nvm
mkdir ~/.nvm
# Agregar a ~/.zshrc:
# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

nvm install --lts
nvm use --lts

# Python
brew install python@3.11

# Ruby (ya incluido en macOS, pero para versión más nueva)
brew install ruby

# Go
brew install go

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Java (OpenJDK)
brew install openjdk@17

# Bun (JavaScript runtime rápido)
curl -fsSL https://bun.sh/install | bash
```

### Bases de Datos

```bash
# PostgreSQL
brew install postgresql@15
brew services start postgresql@15

# MySQL
brew install mysql
brew services start mysql

# MongoDB
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb-community

# Redis
brew install redis
brew services start redis

# SQLite (ya incluido en macOS)
brew install sqlite
```

### Contenedores

```bash
# Docker Desktop
brew install --cask docker

# Orbstack (alternativa ligera a Docker Desktop)
brew install --cask orbstack
```

---

## 🐛 Troubleshooting

### Problemas con Homebrew

```bash
# Permisos
sudo chown -R $(whoami) /opt/homebrew

# Reinstalar Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Problemas con PATH

```bash
# Ver PATH actual
echo $PATH

# Agregar a PATH temporalmente
export PATH="/nueva/ruta:$PATH"

# Agregar permanentemente (en ~/.zshrc)
echo 'export PATH="/nueva/ruta:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Limpiar Caches

```bash
# Cache de Homebrew
brew cleanup -s

# Cache de npm
npm cache clean --force

# Cache de pip
pip cache purge

# Cache del sistema
sudo rm -rf ~/Library/Caches/*
```

---

## 🔗 Referencias

- [Homebrew](https://brew.sh/)
- [macOS Defaults](https://macos-defaults.com/)
- [Awesome macOS](https://github.com/iCHAIT/awesome-macOS)

---

⬅️ [Volver al README](../README.md)

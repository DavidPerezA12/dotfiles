# 🚀 Dotfiles de David Perez

> Mi configuración personal para desarrollo en macOS con iTerm2, Zsh, Neovim y más.

[![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![iTerm2](https://img.shields.io/badge/iTerm2-000000?style=flat&logo=iterm2&logoColor=white)](https://iterm2.com/)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?style=flat&logo=neovim&logoColor=white)](https://neovim.io/)
[![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=flat&logo=zsh&logoColor=white)](https://www.zsh.org/)

## 📋 Tabla de Contenidos

- [Instalación Rápida](#-instalación-rápida)
- [Apps que Uso](#-apps-que-uso)
- [Herramientas CLI](#️-herramientas-cli)
- [Características](#-características)
- [Estructura](#-estructura)
- [Documentación](#-documentación)
- [Personalización](#-personalización)

---

## ⚡ Instalación Rápida

```bash
# Clonar el repositorio
mkdir -p ~/Developer
git clone https://github.com/DavidPerezA12/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles

# Ejecutar el instalador
chmod +x install.sh
./install.sh

# Recargar configuración
source ~/.zshrc
```

El instalador automáticamente:
- ✅ Instala Homebrew (si no está instalado)
- ✅ Instala herramientas CLI esenciales (git, neovim, curl, wget)
- ✅ Instala NVM para gestión de versiones de Node.js
- ✅ Configura Zsh + Oh My Zsh + Powerlevel10k
- ✅ Instala Neovim con plugins y configuración completa
- ✅ Instala fuentes Nerd Fonts para iTerm2
- ✅ Crea symlinks directos a tus dotfiles
- ✅ Configura integración con iTerm2 (si existe config/iterm2/)

Para una pasada rápida sin tocar Homebrew ni resincronizar plugins de Neovim:

```bash
RUN_BREW=0 RUN_LAZY_SYNC=0 ./install.sh
```

### Fuente oficial de configuración

Este repositorio es la fuente de verdad. La configuración activa en `HOME` debe
ser solo un conjunto de symlinks hacia el repo:

```text
~/.config/nvim -> ~/Developer/dotfiles/config/nvim
~/.zshrc       -> ~/Developer/dotfiles/zshrc
~/.zprofile    -> ~/Developer/dotfiles/zprofile
~/.p10k.zsh    -> ~/Developer/dotfiles/p10k.zsh
```

Para cambiar la configuración, edita el repo. No edites directamente
`~/.config/nvim`, `~/.zshrc`, `~/.zprofile` ni `~/.p10k.zsh`, porque son enlaces.

---

## 💻 Apps que Uso

*Nota: Estas son las aplicaciones que uso personalmente. El instalador solo configura las herramientas esenciales (iTerm2 y fuentes). Las demás apps son opcionales y puedes instalarlas manualmente si las necesitas.*

### 🔧 Productividad

| App | Uso | Instalación |
|-----|-----|-------------|
| [**Raycast**](https://www.raycast.com/) | Launcher y productividad | `brew install --cask raycast` |

### 💻 Desarrollo

| App | Uso | Instalación |
|-----|-----|-------------|
| [**iTerm2**](https://iterm2.com/) | Terminal principal | ✅ Instalado automáticamente |
| [**Neovim**](https://neovim.io/) | Editor de código | ✅ Instalado automáticamente |
| [**VS Code**](https://code.visualstudio.com/) | IDE secundario | `brew install --cask visual-studio-code` |
| [**Xcode**](https://developer.apple.com/xcode/) | IDE para iOS/macOS | App Store |


### ⚙️ Otras Utilidades y Herramientas

| App | Uso | Enlace Oficial |
|-----|-----|----------------|
| [**Macs Fan Control**](https://crystalidea.com/macs-fan-control) | Controla los ventiladores del Mac. | [crystalidea.com](https://crystalidea.com/macs-fan-control) |
| [**Amphetamine**](https://apps.apple.com/es/app/amphetamine/id937984704?mt=12) | Evita que el Mac entre en reposo. | App Store |
| [**AlDente**](https://apphousekitchen.com/) | Limita la carga de la batería para alargar su vida útil. | [apphousekitchen.com](https://apphousekitchen.com/) |
| [**Cloudflare WARP**](https://one.one.one.one/) | VPN para una conexión más privada. | [one.one.one.one](https://one.one.one.one/) |
| [**Magnet**](https://apps.apple.com/es/app/magnet/id441258766?mt=12) | Organiza las ventanas del escritorio. | App Store |
| [**CrossOver**](https://www.codeweavers.com/crossover/) | Ejecuta apps y juegos de Windows. | [codeweavers.com](https://www.codeweavers.com/crossover/) |
| [**Parallels Desktop**](https://www.parallels.com/) | Virtualización para ejecutar otros SO. | [parallels.com](https://www.parallels.com/) |
| [**CyberGhost VPN**](https://www.cyberghostvpn.com/) | Servicio de VPN para seguridad. | [cyberghostvpn.com](https://www.cyberghostvpn.com/) |
| [**CleanMyMac X**](https://macpaw.com/cleanmymac) | Limpieza y mantenimiento de macOS. | [macpaw.com](https://macpaw.com/cleanmymac) |
| [**LM Studio**](https://lmstudio.ai/) | Ejecuta LLMs en local. | [lmstudio.ai](https://lmstudio.ai/) |
| [**Cursor**](https://cursor.sh/) | Editor de código "AI-first". | [cursor.sh](https://cursor.sh/) |
| [**Warp**](https://www.warp.dev/) | Terminal moderna con IA. | [warp.dev](https://www.warp.dev/) |

---

## 🛠️ Herramientas CLI

### Esenciales (Instaladas Automáticamente)

Estas herramientas se instalan automáticamente con `./install.sh`:

```bash
# No necesitas ejecutar estos comandos, se instalan solos:
brew install git neovim curl wget

# NVM también se instala automáticamente para gestión de versiones de Node.js
```

| Herramienta | Descripción | Uso |
|-------------|-------------|-----|
| **git** | Control de versiones | `git`, `gst`, `gco`, etc. |
| **neovim** | Editor de código moderno | `nvim` |
| **curl** | Transferencia de datos | `curl` |
| **wget** | Descarga de archivos | `wget` |
| **nvm** | Gestor de versiones de Node.js | `nvm install node` |



📖 **Ver todos los comandos y aliases**: [docs/COMMANDS.md](docs/COMMANDS.md)

---

## ✨ Características

### 🎨 Terminal Hermosa
- **iTerm2** con tema personalizado
- **Powerlevel10k** para un prompt elegante y funcional
- **Nerd Fonts** con iconos y ligaduras

### ⚡ Zsh Optimizado
- **Oh My Zsh** como framework
- Plugins:
  - `git` - Aliases útiles
  - `zsh-autosuggestions` - Sugerencias del historial
  - `zsh-syntax-highlighting` - Resaltado de sintaxis

### 🎯 Neovim Completo
- **Lazy.nvim** - Gestor de plugins moderno
- **LSP** configurado con Mason
- **Telescope** - Fuzzy finding potente
- **GitHub Copilot** integrado
- **Treesitter** - Highlighting avanzado
- **+20 plugins** optimizados

📖 **Ver keymaps de Neovim**: [docs/NEOVIM.md](docs/NEOVIM.md)

---

## 📁 Estructura

```
~/Developer/dotfiles/
├── README.md              # Este archivo
├── install.sh             # Script de instalación
├── Brewfile               # Lista de paquetes Homebrew
├── .gitignore             # Archivos ignorados
├── .env.example           # Template para variables de entorno
├── AGENTS.md              # Instrucciones para agentes de IA
│
├── zshrc                  # Configuración de Zsh
├── zprofile               # PATH de login shell para macOS/Homebrew
├── p10k.zsh               # Configuración de Powerlevel10k
│
├── config/
│   ├── nvim/              # Configuración de Neovim
│   │   ├── init.lua
│   │   └── lua/David/
│   └── iterm2/            # Configuración de iTerm2
│       └── com.googlecode.iterm2.plist
│
└── docs/                  # Documentación
    ├── COMMANDS.md        # Comandos y aliases
    ├── NEOVIM.md          # Guía de Neovim
    └── MACOS_SETUP.md     # Configuración de macOS
```

---

## 📚 Documentación

- 📟 [**Comandos y Aliases**](docs/COMMANDS.md) - Todos los comandos disponibles
- 🎯 [**Guía de Neovim**](docs/NEOVIM.md) - Keymaps y plugins
- 🍎 [**Setup de macOS**](docs/MACOS_SETUP.md) - Configuración del sistema

---

## 🎨 Personalización (Opcional)

*Todo funciona automáticamente después de la instalación. Estos pasos son solo si quieres personalizar algo.*

### Cambiar Tema de Powerlevel10k

```bash
p10k configure
```

### Añadir Plugins a Zsh

Edita `~/Developer/dotfiles/zshrc`:

```bash
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    tu-nuevo-plugin
)
```

### Modificar Keymaps de Neovim

```bash
nvim ~/Developer/dotfiles/config/nvim/lua/David/core/keymaps.lua
```

### Variables de Entorno

```bash
# Copiar template
cp ~/Developer/dotfiles/.env.example ~/Developer/dotfiles/.env

# Editar con tus valores
nvim ~/Developer/dotfiles/.env

# Agregar a tu zshrc (si no está)
echo '[ -f ~/Developer/dotfiles/.env ] && source ~/Developer/dotfiles/.env' >> ~/Developer/dotfiles/zshrc
```

---

## 🔄 Actualización

```bash
cd ~/Developer/dotfiles
git pull origin main

# Reinstalar si hay cambios importantes
./install.sh
```

---

## 🗑️ Desinstalación

```bash
# Eliminar symlinks
rm ~/.zshrc ~/.zprofile ~/.p10k.zsh
rm -rf ~/.config/nvim

# Restaurar backups
ls -la ~/.dotfiles-backups

# Eliminar repositorio
rm -rf ~/Developer/dotfiles
```

---

## 🐛 Troubleshooting

### Iconos no se muestran

```bash
# Instalar Nerd Fonts
brew install --cask font-meslo-lg-nerd-font

# Configurar en iTerm2: Preferences > Profiles > Text > Font
```

### Comandos no encontrados

```bash
# Agregar Homebrew al PATH si no usas este repo
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/Developer/dotfiles/zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Neovim: plugins no se instalan

```bash
# Abrir Neovim y ejecutar
:Lazy sync
```

---

## 📦 Backup y Restauración

### Crear Brewfile de tu sistema actual

```bash
cd ~/Developer/dotfiles
brew bundle dump --force
```

### Restaurar desde Brewfile

```bash
cd ~/Developer/dotfiles
brew bundle install
```

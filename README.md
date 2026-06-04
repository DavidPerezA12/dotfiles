# Dotfiles de David Perez

Configuración personal para desarrollo en macOS. Incluye Zsh, iTerm2, Neovim,
Homebrew y algunos scripts para dejar el entorno en el mismo estado en máquinas
nuevas o reinstaladas.

## Instalación

Puedes clonar el repo donde prefieras. En mis máquinas uso
`~/Developer/dotfiles`, y por eso aparece en algunos ejemplos.

```bash
mkdir -p ~/Developer
git clone https://github.com/DavidPerezA12/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles

chmod +x install.sh
./install.sh

source ~/.zshrc
```

El instalador hace lo siguiente:

- Instala Homebrew si no está disponible.
- Instala las herramientas definidas en `Brewfile`.
- Instala NVM para gestionar versiones de Node.js.
- Configura Zsh, Oh My Zsh y Powerlevel10k.
- Configura Neovim y sincroniza plugins.
- Instala fuentes Nerd Fonts para iTerm2.
- Crea symlinks desde `HOME` hacia este repositorio.
- Aplica la configuración de iTerm2 si existe `config/iterm2/`.

Para una pasada rápida sin tocar Homebrew ni resincronizar plugins de Neovim:

```bash
./install.sh --no-brew --no-nvim-sync
```

Para verificar que todo sigue conectado sin instalar ni modificar nada:

```bash
./install.sh --verify
```

También hay atajos con `make`:

```bash
make install
make quick
make verify
```

## Fuente de verdad

La configuración se edita en este repositorio, esté donde esté clonado. El
instalador calcula la ruta real del checkout y crea enlaces desde `HOME` hacia
esa carpeta.

Si clonaste el repo en `~/Developer/dotfiles`, los enlaces quedan así:

```text
~/.config/nvim -> ~/Developer/dotfiles/config/nvim
~/.zshrc       -> ~/Developer/dotfiles/zshrc
~/.zprofile    -> ~/Developer/dotfiles/zprofile
~/.p10k.zsh    -> ~/Developer/dotfiles/p10k.zsh
```

No edites directamente `~/.config/nvim`, `~/.zshrc`, `~/.zprofile` ni
`~/.p10k.zsh`, porque son enlaces. Edita los archivos equivalentes dentro del
repo que hayas clonado.

## Aplicaciones

El instalador deja listas las herramientas gestionadas por este repo. El resto
son aplicaciones que uso según la máquina o el momento y pueden estar
instaladas por App Store, descarga directa u otra vía manual.

### Productividad

| App | Uso | Instalación |
| --- | --- | --- |
| [Raycast](https://www.raycast.com/) | Launcher y productividad | App instalada manualmente |

### Desarrollo

| App | Uso | Instalación |
| --- | --- | --- |
| [iTerm2](https://iterm2.com/) | Terminal principal | Instalado por el script |
| [Neovim](https://neovim.io/) | Editor de código | Instalado por el script |
| [VS Code](https://code.visualstudio.com/) | IDE secundario | App instalada manualmente |
| [Xcode](https://developer.apple.com/xcode/) | IDE para iOS/macOS | App Store |

### Otras utilidades

| App | Uso | Enlace |
| --- | --- | --- |
| [Macs Fan Control](https://crystalidea.com/macs-fan-control) | Control de ventiladores | [crystalidea.com](https://crystalidea.com/macs-fan-control) |
| [Amphetamine](https://apps.apple.com/es/app/amphetamine/id937984704?mt=12) | Mantener el Mac despierto | App Store |
| [AlDente](https://apphousekitchen.com/) | Límite de carga de batería | [apphousekitchen.com](https://apphousekitchen.com/) |
| [Cloudflare WARP](https://one.one.one.one/) | VPN | [one.one.one.one](https://one.one.one.one/) |
| [Magnet](https://apps.apple.com/es/app/magnet/id441258766?mt=12) | Gestión de ventanas | App Store |
| [CrossOver](https://www.codeweavers.com/crossover/) | Apps y juegos de Windows | [codeweavers.com](https://www.codeweavers.com/crossover/) |
| [Parallels Desktop](https://www.parallels.com/) | Virtualización | [parallels.com](https://www.parallels.com/) |
| [CyberGhost VPN](https://www.cyberghostvpn.com/) | VPN | [cyberghostvpn.com](https://www.cyberghostvpn.com/) |
| [CleanMyMac X](https://macpaw.com/cleanmymac) | Limpieza de macOS | [macpaw.com](https://macpaw.com/cleanmymac) |
| [LM Studio](https://lmstudio.ai/) | Modelos locales | [lmstudio.ai](https://lmstudio.ai/) |
| [Cursor](https://cursor.sh/) | Editor de código | [cursor.sh](https://cursor.sh/) |
| [Warp](https://www.warp.dev/) | Terminal alternativa | [warp.dev](https://www.warp.dev/) |

## Herramientas CLI

Estas herramientas se instalan con `./install.sh`:

```bash
brew bundle install --file ./Brewfile
```

| Herramienta | Descripción | Uso |
| --- | --- | --- |
| `git` | Control de versiones | `git`, `gst`, `gco` |
| `neovim` | Editor de código | `nvim` |
| `curl` | Transferencia de datos | `curl` |
| `wget` | Descarga de archivos | `wget` |
| `ripgrep` | Búsqueda rápida de texto | `rg "texto"` |
| `fd` | Búsqueda rápida de archivos | `fd nombre` |
| `fzf` | Selector fuzzy interactivo | `fzf` |
| `lazygit` | UI terminal para Git | `lazygit` |
| `tmux` | Multiplexor de terminal | `tmux` |
| `shellcheck` | Linter para scripts shell | `shellcheck install.sh` |
| `nvm` | Gestor de versiones de Node.js | `nvm install node` |

[Ver todos los comandos y aliases](docs/COMMANDS.md).

## Qué queda configurado

### Terminal

- iTerm2 con configuración propia.
- Powerlevel10k para el prompt.
- Nerd Fonts para iconos.

### Zsh

- Oh My Zsh.
- `git`.
- `zsh-autosuggestions`.
- `zsh-syntax-highlighting`.

### Neovim

- `lazy.nvim` para plugins.
- LSP configurado con Mason.
- Telescope para búsquedas.
- GitHub Copilot.
- Treesitter.
- Plugins de Git, terminal, debug y navegación.

[Ver keymaps de Neovim](config/nvim/README.md).

## Estructura

```text
dotfiles/
├── README.md              # Este archivo
├── install.sh             # Script de instalación
├── Brewfile               # Paquetes Homebrew
├── .gitignore             # Archivos ignorados
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
    └── MACOS_SETUP.md     # Configuración de macOS
```

## Documentación

- [Comandos y aliases](docs/COMMANDS.md)
- [Guía de Neovim](config/nvim/README.md)
- [Setup de macOS](docs/MACOS_SETUP.md)

## Mantenimiento

### Verificar configuración

```bash
make verify
./install.sh --verify
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_REQUIRE_TAP_TRUST=1 brew bundle check --file ./Brewfile
shellcheck install.sh
nvim --headless "+checkhealth" +qa
```

### Actualizar herramientas

```bash
brew update
brew upgrade
brew bundle install --file ./Brewfile
```

### Sincronizar Neovim

```bash
nvim --headless "+Lazy! sync" +qa
```

### Revisar enlaces

```bash
readlink ~/.config/nvim
readlink ~/.zshrc
readlink ~/.zprofile
readlink ~/.p10k.zsh
```

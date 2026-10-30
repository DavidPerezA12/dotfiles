# Dotfiles de David Perez

Mi Mac, descrito en archivos. Clonas el repo, ejecutas un script y un Mac nuevo
queda con el mismo shell, editor, Git, herramientas y apps que los demás.

Lo uso para tres cosas:

- **Preparar un Mac nuevo** con un solo comando, sin acordarme de qué instalé.
- **Mantener mis Macs iguales.** La configuración vive aquí y se enlaza a
  `HOME`, así que editar un archivo del repo es cambiar el ajuste real.
- **Documentar mi setup.** Si una herramienta o app está en mis Macs, está
  listada aquí.

## Qué incluye

| Área | Qué configura |
| --- | --- |
| Shell | [Zsh](zshrc) con Oh My Zsh, Powerlevel10k, sugerencias y resaltado de sintaxis |
| Terminal | [Preferencias de iTerm2](config/iterm2) y la fuente MesloLGS NF |
| Editor | [Neovim](config/nvim/README.md) con LSP, Telescope, Treesitter, depuración y Copilot |
| Git | [Config compartida](.gitconfig): alias, diffs legibles, `rerere`, login con `gh` |
| SSH | Un host `macmini` por Tailscale, en [config/ssh/config](config/ssh/config) |
| Herramientas CLI | [Brewfile](Brewfile): `ripgrep`, `fd`, `fzf`, `lazygit`, `tmux`, linters, herramientas de Java/Android, PostgreSQL, Supabase CLI, agentes de código |
| Apps de escritorio | [Brewfile.apps](Brewfile.apps): Chrome, Tailscale, Raycast, VS Code, T3 Code, Docker y más, desde casks de Homebrew o la App Store |
| Ajustes de macOS | [macos-defaults.sh](scripts/macos-defaults.sh): modo oscuro, tap para clic, Finder, Dock, capturas |

## Cómo funciona

### Un instalador, seguro de repetir

[install.sh](install.sh) hace todo el setup:

1. Instala Homebrew y todo lo del `Brewfile`.
2. Instala Oh My Zsh, Powerlevel10k, NVM, Claude Code y Bun.
3. Enlaza la configuración en `HOME`.
4. Añade el include de SSH, apunta iTerm2 a este repo y sincroniza los plugins
   de Neovim.

Ejecutarlo otra vez no hace daño: solo arregla lo que falta. Cualquier archivo
que vaya a reemplazar se mueve antes a `~/.dotfiles-backups/<fecha>/`, así que
no se pierde nada.

### Symlinks, no copias

[zshrc](zshrc), [zprofile](zprofile), [p10k.zsh](p10k.zsh),
[.gitconfig](.gitconfig), [.gitignore_global](.gitignore_global) y
[config/nvim](config/nvim) son symlinks a sus ubicaciones habituales. No hay
paso de sincronización: editas el archivo aquí y la herramienta lo ve. iTerm2
lee sus preferencias directamente de [config/iterm2](config/iterm2), y SSH
incorpora los hosts compartidos con un `Include`, así cada Mac conserva sus
hosts privados.

### Config compartida, datos privados

El repo solo guarda configuración. Credenciales, claves privadas, sesiones, la
identidad de Git (`~/.gitconfig.local`) y el nombre real del mini
(`~/.ssh/config.local`) se quedan en cada Mac. Por eso es seguro tener el repo
público.

### Las apps van aparte

`install.sh` no instala apps. Algunas son pesadas o de pago, las de la App Store
necesitan un Apple ID con sesión iniciada y AlDente solo tiene sentido en
portátiles. Así también se puede reutilizar la parte de terminal en una máquina
sin apps de escritorio.

## Preparar un Mac

Con las Xcode Command Line Tools disponibles (`xcode-select --install`):

```bash
git clone https://github.com/DavidPerezA12/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles
./install.sh
```

Reinicia la terminal. Luego completa los pasos manuales (login de GitHub,
identidad de Git, Node con NVM, sesiones y permisos de las apps) en
[Configuración de macOS](docs/MACOS_SETUP.md).

Para las apps de escritorio, revisa antes [Brewfile.apps](Brewfile.apps) y luego:

```bash
brew bundle --file Brewfile.apps
```

Ese comando instala la lista completa para el Mac cliente. En el Mac mini,
el agente debe preguntar primero qué herramientas de desarrollo y apps se
necesitan, siguiendo `docs/DEVELOPMENT.md` de Serverfiles, e instalar solo la
selección acordada. Wispr Flow se queda en el MacBook y se excluye del mini.
En ambos equipos se acuerda primero qué instalar siguiendo la
[guía de selección](docs/INSTALL_CHOICES.md). Si solo se ha elegido parte de
la lista, se instalan esas apps individualmente.

Opciones del instalador: `--no-brew`, `--no-nvim-sync` y `--no-iterm2` saltan
partes, y `--verify` solo comprueba. `--links-only` y `make quick` solo
reenlazan la configuración, sin descargas ni cambios de ajustes de apps.

## Comandos habituales

| Comando | Qué hace |
| --- | --- |
| `make install` | Ejecuta el instalador completo |
| `make quick` | Solo reenlaza la config |
| `make verify` | Lint, Brewfile, enlaces, SSH, iTerm2, prompt y config de Neovim |
| `make test` | Pruebas del instalador en un HOME temporal, sin descargas |
| `make macos` | Aplica mis ajustes de macOS |
| `make nvim-sync` | Actualiza los plugins de Neovim |
| `make nvim-health` | Abre el informe de salud de Neovim |

Para actualizar las herramientas: `brew update && brew upgrade`, luego
`make nvim-sync` y `make verify`.

## El Mac mini

Mi Mac mini, que hace de servidor casero, tiene su propio repo:
[Serverfiles](https://github.com/DavidPerezA12/ServerFiles). Reutiliza de aquí
las herramientas, el shell, Git y Neovim, y añade sus servicios, monitorización,
acceso remoto y ajustes de energía. Este repo solo cubre el lado cliente: cómo
conectarse por SSH y Tailscale, en la [guía del Mac mini](docs/MAC_MINI.md).

## Estructura del repo

```text
install.sh          instalador
Brewfile            herramientas de terminal y desarrollo
Brewfile.apps       apps de escritorio
zshrc, zprofile, p10k.zsh, .gitconfig, .gitignore_global
config/             nvim, iterm2, ssh
scripts/            ajustes de macOS y comprobación del prompt
docs/               setup, comandos, prompt, Mac mini
AGENTS.md           instrucciones para agentes de IA que trabajan en el repo
```

## Más información

- [Configuración de macOS](docs/MACOS_SETUP.md): pasos manuales, sesiones de apps y CLIProxyAPI.
- [Comandos](docs/COMMANDS.md): alias del shell y uso diario.
- [Neovim](config/nvim/README.md): plugins, atajos y solución de problemas.
- [Prompt de la terminal](docs/TERMINAL_PROMPT.md): comportamiento y rarezas de Powerlevel10k.
- [Mac mini](docs/MAC_MINI.md): SSH, T3 Code, monitorización y problemas de conexión.
- [Sincronización](docs/SYNC.md): comparar ambos Macs con GitHub, preservar cambios y verificar lo aplicado.

## Licencia

MIT.

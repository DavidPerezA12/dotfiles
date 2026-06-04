# 📟 Guía de Comandos y Aliases

Documentación completa de comandos, aliases y funciones disponibles en esta configuración.

## 📑 Tabla de Contenidos

- [Aliases Generales](#aliases-generales)
- [Aliases de Git](#aliases-de-git)
- [Herramientas CLI Modernas](#herramientas-cli-modernas)
- [Navegación y Búsqueda](#navegación-y-búsqueda)
- [Tips y Trucos](#tips-y-trucos)

---

## 🔧 Aliases Generales

### Aliases de Aplicaciones macOS

```bash
xcode       # Abre Xcode
```

### Navegación Mejorada

```bash
ls          # Comando ls estándar
cat         # Comando cat estándar
```

---

## 🐙 Aliases de Git

Provistos por el plugin `git` de Oh My Zsh:

```bash
# Status y básicos
g           # git
gst         # git status
gss         # git status -s

# Add y Commit
ga          # git add
gaa         # git add --all
gc          # git commit -v
gc!         # git commit -v --amend
gca         # git commit -v -a
gcam        # git commit -a -m

# Branch
gb          # git branch
gba         # git branch -a
gbd         # git branch -d
gbD         # git branch -D

# Checkout
gco         # git checkout
gcb         # git checkout -b
gcm         # git checkout main/master

# Pull y Push
gl          # git pull
gp          # git push
gpf         # git push --force-with-lease
gpu         # git push upstream

# Log
glog        # git log --oneline --decorate --graph
gloga       # git log --oneline --decorate --graph --all
glg         # git log --stat
glgg        # git log --graph

# Diff
gd          # git diff
gds         # git diff --staged
gdw         # git diff --word-diff

# Merge y Rebase
gm          # git merge
gma         # git merge --abort
grb         # git rebase
grbi        # git rebase -i
grba        # git rebase --abort
grbc        # git rebase --continue

# Stash
gsta        # git stash
gstp        # git stash pop
gstl        # git stash list

# Remote
gr          # git remote
gra         # git remote add
grv         # git remote -v
```

---

## 🚀 Herramientas CLI Esenciales

Estas herramientas se instalan desde el `Brewfile` con `./install.sh` o con:

```bash
brew bundle install --file ~/Developer/dotfiles/Brewfile
```

### `git` - Control de Versiones

```bash
git status                   # Ver estado
git add .                    # Agregar todos los cambios
git commit -m "mensaje"      # Hacer commit
git push                     # Subir cambios
```

### `neovim` - Editor Moderno

```bash
nvim archivo.txt             # Abrir archivo
nvim .                       # Abrir directorio actual
:Lazy                        # Gestor de plugins
:Mason                       # Gestor de LSP
```

### `nvm` - Gestor de Versiones de Node

```bash
# Instalación y gestión
nvm install node             # Instalar última versión
nvm install 20.10.0          # Instalar versión específica
nvm install --lts            # Instalar versión LTS
nvm use 20.10.0              # Usar versión específica
nvm use node                 # Usar última versión
nvm use --lts                # Usar versión LTS

# Listado y búsqueda
nvm ls                       # Listar versiones instaladas
nvm ls-remote                # Listar versiones disponibles
nvm ls-remote --lts          # Listar versiones LTS
nvm current                  # Versión actual en uso

# Utilidades
nvm uninstall 20.10.0        # Desinstalar versión
nvm alias default 20.10.0    # Establecer versión por defecto
nvm which node               # Ruta del ejecutable node actual
```

### `curl` y `wget` - Transferencia de Datos

```bash
curl https://example.com     # Descargar contenido
curl -O https://example.com/file.txt  # Descargar archivo
wget https://example.com/file.txt     # Descargar archivo
```

### `ripgrep`, `fd` y `fzf` - Búsqueda Rápida

```bash
rg "TODO"                    # Buscar texto en el proyecto
rg "TODO" -l                 # Mostrar solo archivos con coincidencias
fd config                    # Buscar archivos/carpetas por nombre
fd lua config/nvim           # Buscar archivos lua bajo config/nvim
fzf                          # Selector fuzzy interactivo
nvim "$(fd . | fzf)"         # Elegir un archivo y abrirlo en Neovim
```

### `lazygit` - Git en Terminal

```bash
lazygit                      # Abrir UI de Git
```

En Neovim también está disponible desde `<leader>gg`.

### `tmux` - Sesiones de Terminal

```bash
tmux                         # Nueva sesión
tmux new -s trabajo          # Nueva sesión con nombre
tmux ls                      # Listar sesiones
tmux attach -t trabajo       # Volver a una sesión
```

### `shellcheck` - Validar Scripts Shell

```bash
shellcheck install.sh        # Revisar el instalador
```

---

## 🧭 Navegación y Búsqueda

### Combinaciones Útiles

```bash
# Buscar y editar con Neovim
nvim $(fzf)

# Buscar contenido y abrir archivo
rg "TODO" -l | fzf | xargs nvim

# Ver historial de git de un archivo
glog -- archivo.txt
```

---

## 💡 Tips y Trucos

### Recargar Configuración

```bash
source ~/.zshrc              # Recargar zshrc
exec zsh                     # Reiniciar shell
```

### Powerlevel10k

```bash
p10k configure               # Reconfigurar tema
p10k segment list            # Ver segmentos disponibles
```

### Neovim

```bash
nvim                         # Abrir Neovim
:Lazy                        # Gestor de plugins
:Mason                       # Gestor de LSP
:checkhealth                 # Verificar salud
```

### Historial

```bash
history | grep comando       # Buscar en historial
!!                           # Repetir último comando
!$                           # Último argumento del comando anterior
!*                           # Todos los argumentos del comando anterior
```

### Homebrew

```bash
brew update                  # Actualizar Homebrew
brew upgrade                 # Actualizar paquetes
brew outdated                # Ver paquetes desactualizados
brew cleanup                 # Limpiar versiones antiguas
brew list                    # Lista de paquetes instalados
brew info <paquete>          # Información del paquete
```

### Dotfiles

```bash
cd ~/Developer/dotfiles
make verify                 # Ejecutar verificaciones locales
make quick                  # Reenlazar rápido sin brew/lazy sync
make nvim-sync              # Sincronizar plugins de Neovim
./install.sh --verify        # Verificar symlinks y sintaxis sin instalar
./install.sh --no-brew --no-nvim-sync    # Reenlazar rápido sin brew/lazy sync
./install.sh --no-iterm2     # Instalar sin tocar configuración de iTerm2
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_REQUIRE_TAP_TRUST=1 brew bundle check --file Brewfile
```

### Git local privado

La configuración global de Git vive en `~/.gitconfig`, enlazada desde este repo.
Los datos privados o específicos de una máquina van en `~/.gitconfig.local`:

```ini
[user]
  email = tu@email.com
```

---

## 🔗 Referencias

- [Oh My Zsh Cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet)
- [ripgrep Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
- [fd GitHub](https://github.com/sharkdp/fd)
- [fzf Wiki](https://github.com/junegunn/fzf/wiki)
- [Neovim Keymaps](../config/nvim/README.md)

---

⬅️ [Volver al README](../README.md)

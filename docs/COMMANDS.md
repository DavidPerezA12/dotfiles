# 📟 Guía de Comandos y Aliases

Documentación completa de comandos, aliases y funciones disponibles en esta configuración.

## 📑 Tabla de Contenidos

- [Aliases Generales](#aliases-generales)
- [Aliases de Git](#aliases-de-git)
- [Herramientas CLI Modernas](#herramientas-cli-modernas)
- [Funciones de IA](#funciones-de-ia)
- [Navegación y Búsqueda](#navegación-y-búsqueda)
- [Tips y Trucos](#tips-y-trucos)

---

## 🔧 Aliases Generales

### Aliases de Aplicaciones macOS

```bash
idea        # Abre IntelliJ IDEA
xcode       # Abre Xcode
sublime     # Abre Sublime Text
```

### Navegación Mejorada

```bash
ls          # Reemplazado por eza con iconos y colores
ll          # Lista detallada con eza
la          # Lista todo incluyendo archivos ocultos
cat         # Reemplazado por bat con syntax highlighting
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

## 🚀 Herramientas CLI Modernas

### `eza` - Mejor ls

```bash
eza                          # Lista archivos básico
eza -la                      # Lista detallada con ocultos
eza --tree                   # Vista de árbol
eza --tree --level=2         # Árbol con profundidad 2
eza -la --git                # Muestra estado de Git
```

### `bat` - cat con Superpoderes

```bash
bat archivo.txt              # Ver archivo con syntax highlighting
bat -n archivo.txt           # Con números de línea
bat -A archivo.txt           # Muestra todos los caracteres
bat archivo1.txt archivo2.txt # Ver múltiples archivos
```

### `ripgrep (rg)` - Búsqueda Ultrarrápida

```bash
rg "patrón"                  # Busca en directorio actual
rg "patrón" -i               # Búsqueda case-insensitive
rg "patrón" -t py            # Solo archivos Python
rg "patrón" -g "*.js"        # Solo archivos .js
rg "patrón" -l               # Solo nombres de archivos
rg "patrón" --hidden         # Incluir archivos ocultos
```

### `fd` - Alternativa a find

```bash
fd archivo                   # Busca archivos por nombre
fd "\.js$"                   # Busca por extensión
fd -e js                     # Busca archivos .js
fd -H archivo                # Incluir archivos ocultos
fd -t f                      # Solo archivos
fd -t d                      # Solo directorios
```

### `fzf` - Fuzzy Finder

```bash
# Ctrl+R                     # Buscar en historial
# Ctrl+T                     # Buscar archivos
# Alt+C                      # Cambiar directorio

vim $(fzf)                   # Abrir archivo con fzf
cd $(fd -t d | fzf)          # Cambiar a directorio con fzf
```

### `zoxide` - cd Inteligente

```bash
z proyectos                  # Salta a directorio frecuente
zi                           # Selector interactivo
z -                          # Directorio anterior
```

### `jq` - Procesador JSON

```bash
cat data.json | jq           # Formato bonito
cat data.json | jq '.name'   # Extraer campo
cat data.json | jq '.[] | .id' # Iterar array
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

# Aliases personalizados
nvm-latest                   # Instalar última versión y migrar packages
nvm-lts                      # Instalar LTS y migrar packages
nvm-list                     # Listar versiones LTS remotas

# Utilidades
nvm uninstall 20.10.0        # Desinstalar versión
nvm alias default 20.10.0    # Establecer versión por defecto
nvm which node               # Ruta del ejecutable node actual
```

### `tree` - Visualizar Estructura

```bash
tree                         # Árbol completo
tree -L 2                    # Solo 2 niveles
tree -a                      # Incluir ocultos
tree -I 'node_modules'       # Ignorar carpeta
```

---

## 🤖 Funciones de IA

### Comando `ia`

Pregunta directamente a la IA desde terminal (requiere `OPENROUTER_API_KEY`):

```bash
ia "cómo buscar archivos por fecha"
ia "comando para ver procesos en macOS"
ia "script para renombrar archivos en bash"
ia --solo "respuesta sin streaming"
```

### Gestión de Reglas

```bash
ia-rules                     # Ver reglas actuales
ia-rules "Nuevas reglas"     # Cambiar reglas del sistema
ia-rules --reset             # Restaurar reglas por defecto
```

---

## 🧭 Navegación y Búsqueda

### Combinaciones Útiles

```bash
# Buscar y editar con Neovim
nvim $(fzf)

# Buscar contenido y abrir archivo
rg "TODO" -l | fzf | xargs nvim

# Ir a directorio del proyecto rápidamente
z proyecto && nvim .

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

---

## 🔗 Referencias

- [Oh My Zsh Cheatsheet](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet)
- [eza GitHub](https://github.com/eza-community/eza)
- [bat GitHub](https://github.com/sharkdp/bat)
- [ripgrep Guide](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
- [fd GitHub](https://github.com/sharkdp/fd)
- [fzf Wiki](https://github.com/junegunn/fzf/wiki)
- [Neovim Keymaps](./NEOVIM.md)

---

⬅️ [Volver al README](../README.md)

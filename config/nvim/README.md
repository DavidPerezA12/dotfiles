# Neovim

Mi configuración de Neovim. Está pensada para trabajar rápido en proyectos de
código sin tener que pelearme mucho con el editor: fuzzy finding, LSP,
diagnósticos, Git, terminal integrada y algunos atajos que uso a diario.

La configuración vive aquí:

```text
~/Developer/dotfiles/config/nvim
```

Y la instalación activa debería apuntar a esta carpeta:

```text
~/.config/nvim -> ~/Developer/dotfiles/config/nvim
```

## Instalación

Desde la raíz del repo:

```bash
./install.sh
```

El script crea el symlink y deja Neovim usando esta configuración. Al abrir
`nvim` por primera vez, `lazy.nvim` descarga los plugins.

Requisitos útiles:

- Neovim 0.9 o superior
- Git
- ripgrep, para las búsquedas de Telescope
- Node.js, Python, Go o Rust solo si vas a usar sus language servers
- lazygit, si quieres abrirlo desde Neovim

Para comprobar que el enlace apunta al sitio correcto:

```bash
readlink ~/.config/nvim
```

## Estructura

```text
config/nvim/
├── init.lua
├── lazy-lock.json
└── lua/David/
    ├── core/
    │   ├── options.lua
    │   └── keymaps.lua
    ├── lazy-setup.lua
    └── plugins/
        ├── lsp/
        └── *.lua
```

- `init.lua` carga opciones, keymaps y plugins.
- `core/options.lua` contiene comportamiento base del editor.
- `core/keymaps.lua` guarda los atajos generales.
- `plugins/` tiene cada plugin separado en su propio archivo.
- `plugins/lsp/` agrupa Mason, LSP, formatters y herramientas relacionadas.

## Cosas configuradas

- `lazy.nvim` para gestionar plugins.
- `nightfly` como tema principal.
- `telescope.nvim` para buscar archivos, texto, buffers y ayuda.
- `nvim-tree.lua` como explorador de archivos.
- `nvim-lspconfig`, `mason.nvim` y `nvim-cmp` para LSP y autocompletado.
- `treesitter` para mejor resaltado y parsing.
- `gitsigns.nvim`, Telescope Git y `lazygit` para trabajar con Git.
- `toggleterm.nvim` para terminales dentro de Neovim.
- `harpoon` para saltar rápido entre archivos frecuentes.
- `trouble.nvim` para diagnósticos, quickfix y símbolos.
- `nvim-dap` para debug.
- `copilot.lua` para sugerencias de Copilot.

## Atajos que más uso

La tecla leader es `Space`.

### Buscar

| Atajo | Hace |
| --- | --- |
| `<leader>ff` | Buscar archivos |
| `<leader>fr` | Archivos recientes |
| `<leader>fs` | Buscar texto en el proyecto |
| `<leader>fc` | Buscar palabra bajo el cursor |
| `<leader>fb` | Buffers abiertos |
| `<leader>fh` | Ayuda de Neovim |

### Archivos y buffers

| Atajo | Hace |
| --- | --- |
| `<leader>ee` | Abrir/cerrar nvim-tree |
| `<leader>ef` | Abrir nvim-tree en el archivo actual |
| `<S-h>` / `<S-l>` | Buffer anterior / siguiente |
| `[b` / `]b` | Buffer anterior / siguiente |
| `<leader>bb` | Volver al último buffer |

### Ventanas y tabs

| Atajo | Hace |
| --- | --- |
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Igualar tamaño de splits |
| `<leader>sx` | Cerrar split |
| `<leader>sm` | Maximizar/restaurar split |
| `<C-h/j/k/l>` | Moverse entre ventanas |
| `<leader><tab>o` | Nueva tab |
| `<leader><tab>x` | Cerrar tab |

### LSP

| Atajo | Hace |
| --- | --- |
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `gR` | Ver referencias |
| `gi` | Ir a implementación |
| `gt` | Ver definición de tipo |
| `K` | Documentación hover |
| `<leader>ca` | Code actions |
| `<leader>rn` | Renombrar símbolo |
| `<leader>d` | Diagnóstico de la línea |
| `<leader>D` | Diagnósticos del buffer |
| `[d` / `]d` | Diagnóstico anterior / siguiente |
| `<leader>rs` | Reiniciar LSP |

### Git

| Atajo | Hace |
| --- | --- |
| `<leader>gs` | Estado de Git con Telescope |
| `<leader>gc` | Commits |
| `<leader>gfc` | Commits del archivo actual |
| `<leader>gb` | Ramas |
| `<leader>gg` | Abrir lazygit |
| `]c` / `[c` | Cambio siguiente / anterior |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame de la línea |

### Terminal

| Atajo | Hace |
| --- | --- |
| `<C-\>` | Abrir/cerrar terminal |
| `<leader>tt` | Terminal flotante |
| `<leader>tH` | Terminal horizontal |
| `<leader>tV` | Terminal vertical |
| `<leader>tj` | Node REPL |
| `<leader>tp` | Python REPL |
| `<leader>tu` | htop |

### Edición y acciones rápidas

| Atajo | Hace |
| --- | --- |
| `jk` | Salir de insert mode |
| `<leader>/` | Comentar línea o selección |
| `<leader>nh` | Quitar resaltado de búsqueda |
| `<leader>+` / `<leader>-` | Incrementar / decrementar número |
| `<leader>ww` | Guardar |
| `<leader>qq` | Salir |
| `<leader>un` | Cerrar notificaciones |

## Comandos útiles

```vim
:Lazy
:Lazy sync
:Mason
:checkhealth
```

Si algo de LSP no aparece, normalmente basta con abrir `:Mason` e instalar el
server que falte. Los binarios de Mason se añaden al `PATH` desde
`core/options.lua`.

## Copilot

Los atajos principales son:

| Atajo | Hace |
| --- | --- |
| `<M-l>` | Aceptar sugerencia |
| `<M-]>` | Siguiente sugerencia |
| `<M-[>` | Sugerencia anterior |
| `<C-]>` | Descartar sugerencia |
| `<M-CR>` | Abrir panel |

## Mantenimiento

Actualizar plugins:

```vim
:Lazy sync
```

Revisar problemas generales:

```vim
:checkhealth
```

Limpiar caché si Neovim queda en un estado raro:

```bash
rm -rf ~/.cache/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
```

Hazlo solo sabiendo que eso borra plugins descargados, estado local y datos
temporales. Al abrir Neovim de nuevo, `lazy.nvim` volverá a instalar lo que
falte.

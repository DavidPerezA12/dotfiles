# 🚀 Guía de Neovim

Configuración completa de Neovim con keymaps, plugins y tips de uso.

## 📑 Tabla de Contenidos

- [Keymaps Generales](#keymaps-generales)
- [Navegación](#navegación)
- [Edición](#edición)
- [Búsqueda y Telescope](#búsqueda-y-telescope)
- [LSP y Autocompletado](#lsp-y-autocompletado)
- [Git](#git)
- [Terminal](#terminal)
- [Plugins Principales](#plugins-principales)

---

## ⌨️ Keymaps Generales

**Leader Key**: `Space`

### Básicos

```
<leader>w       Guardar archivo
<leader>q       Cerrar buffer
<leader>Q       Cerrar sin guardar
<C-h/j/k/l>     Navegar entre splits
<leader>sv      Split vertical
<leader>sh      Split horizontal
<leader>se      Igualar tamaño de splits
<leader>sx      Cerrar split
```

---

## 🧭 Navegación

### Nvim-tree (Explorador de Archivos)

```
<leader>e       Toggle explorador
<leader>ef      Buscar archivo en explorador
```

**Dentro de nvim-tree:**
```
a               Crear archivo/directorio
d               Eliminar
r               Renombrar
x               Cortar
c               Copiar
p               Pegar
y               Copiar nombre
Y               Copiar ruta relativa
gy              Copiar ruta absoluta
```

### Bufferline (Pestañas)

```
<Tab>           Buffer siguiente
<S-Tab>         Buffer anterior
<leader>bd      Cerrar buffer
<leader>bp      Pin/unpin buffer
<leader>bP      Cerrar buffers no pinneados
```

### Harpoon (Navegación Rápida)

```
<leader>ha      Añadir archivo a harpoon
<leader>hh      Ver menú de harpoon
<C-1>           Ir a archivo 1
<C-2>           Ir a archivo 2
<C-3>           Ir a archivo 3
<C-4>           Ir a archivo 4
```

---

## ✏️ Edición

### Autopairs

Se cierran automáticamente:
- Paréntesis `()`
- Corchetes `[]`
- Llaves `{}`
- Comillas `"" ''`
- Backticks ``` `` ```

### Comment

```
gcc             Comentar línea
gc{motion}      Comentar con movimiento
gbc             Comentar bloque
```

### Indent-blankline

Muestra guías de indentación automáticamente.

---

## 🔍 Búsqueda y Telescope

### Telescope (Fuzzy Finder)

```
<leader>ff      Buscar archivos
<leader>fg      Buscar en contenido (grep)
<leader>fb      Buscar en buffers
<leader>fh      Buscar en historial
<leader>fc      Buscar en comandos
<leader>fk      Buscar keymaps
<leader>fr      Buscar archivos recientes
```

**Dentro de Telescope:**
```
<C-j/k>         Navegar resultados
<C-u/d>         Scroll preview
<CR>            Abrir archivo
<C-x>           Abrir en split horizontal
<C-v>           Abrir en split vertical
<C-t>           Abrir en nueva pestaña
```

---

## 💻 LSP y Autocompletado

### LSP (Language Server Protocol)

```
gd              Go to definition
gD              Go to declaration
gi              Go to implementation
gr              Go to references
K               Hover documentation
<leader>ca      Code actions
<leader>rn      Rename símbolo
<leader>f       Format documento
[d              Diagnóstico anterior
]d              Diagnóstico siguiente
<leader>d       Ver diagnósticos del buffer
```

### Mason (Gestor de LSP)

```
:Mason          Abrir gestor de LSP servers
:MasonInstall   Instalar LSP server
:MasonUpdate    Actualizar servers
```

### Autocompletado (nvim-cmp)

```
<C-Space>       Activar autocompletado
<C-n>           Siguiente sugerencia
<C-p>           Sugerencia anterior
<CR>            Confirmar selección
<C-e>           Cerrar autocompletado
<Tab>           Siguiente snippet placeholder
<S-Tab>         Anterior snippet placeholder
```

### GitHub Copilot

```
<leader>ce      Enable Copilot
<leader>cd      Disable Copilot
<leader>cp      Panel de Copilot
```

---

## 🐙 Git

### Gitsigns

```
<leader>gp      Preview hunk
<leader>gr      Reset hunk
<leader>gs      Stage hunk
<leader>gu      Undo stage hunk
<leader>gd      Diff this
<leader>gb      Blame line
]c              Siguiente cambio
[c              Cambio anterior
```

---

## 📟 Terminal

### Toggleterm

```
<C-\>           Toggle terminal
<leader>tf      Terminal flotante
<leader>th      Terminal horizontal
<leader>tv      Terminal vertical
```

**Dentro del terminal:**
```
<C-\>           Volver a Neovim
<C-h/j/k/l>     Navegar entre splits (en modo terminal)
```

---

## 🔌 Plugins Principales

### Installed Plugins

- **lazy.nvim** - Gestor de plugins
- **telescope.nvim** - Fuzzy finder
- **nvim-tree.lua** - Explorador de archivos
- **nvim-treesitter** - Syntax highlighting avanzado
- **nvim-lspconfig** - Configuración LSP
- **mason.nvim** - Gestor de LSP/DAP/linters
- **nvim-cmp** - Autocompletado
- **copilot.vim** - GitHub Copilot
- **lualine.nvim** - Statusline
- **bufferline.nvim** - Bufferline
- **gitsigns.nvim** - Integración Git
- **which-key.nvim** - Ayuda de keymaps
- **trouble.nvim** - Diagnósticos mejorados
- **nvim-autopairs** - Cierre automático
- **comment.nvim** - Comentarios rápidos
- **indent-blankline.nvim** - Guías de indentación
- **alpha-nvim** - Pantalla de inicio
- **harpoon** - Navegación rápida
- **toggleterm.nvim** - Terminal integrado
- **lspsaga.nvim** - UI mejorada para LSP

---

## 🎨 Personalización

### Archivos de Configuración

```
~/Developer/dotfiles/config/nvim/
├── init.lua                    # Punto de entrada
├── lua/David/
│   ├── core/
│   │   ├── options.lua        # Opciones generales
│   │   └── keymaps.lua        # Keymaps personalizados
│   └── plugins/               # Configuración de plugins
```

### Comandos Útiles

```
:checkhealth                   # Verificar salud de Neovim
:Lazy                          # Gestor de plugins
:Lazy sync                     # Sincronizar plugins
:Lazy update                   # Actualizar plugins
:Lazy clean                    # Limpiar plugins no usados
:Mason                         # Gestor de LSP
:LspInfo                       # Info de LSP activo
:TSUpdate                      # Actualizar parsers de Treesitter
```

---

## 💡 Tips

### Movimientos Rápidos

```
w               Siguiente palabra
b               Palabra anterior
e               Final de palabra
0               Inicio de línea
$               Final de línea
gg              Inicio del archivo
G               Final del archivo
{               Párrafo anterior
}               Siguiente párrafo
%               Ir a pareja de paréntesis/llave
```

### Modo Visual

```
v               Modo visual
V               Modo visual línea
<C-v>           Modo visual bloque
>               Indentar
<               Des-indentar
y               Copiar
d               Cortar
p               Pegar
```

### Búsqueda y Reemplazo

```
/patrón         Buscar hacia adelante
?patrón         Buscar hacia atrás
n               Siguiente resultado
N               Resultado anterior
:%s/old/new/g   Reemplazar en todo el archivo
:%s/old/new/gc  Reemplazar con confirmación
```

---

## 🔗 Referencias

- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [LSP Config](https://github.com/neovim/nvim-lspconfig)

---

⬅️ [Volver al README](../README.md)

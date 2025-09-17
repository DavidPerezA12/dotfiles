# 🚀 Configuración Neovim de David

Una configuración moderna y completa de Neovim con lazy.nvim, LSP, debugging, y muchas funcionalidades avanzadas.

## 📋 Tabla de Contenidos
- [Instalación](#instalación)
- [Atajos de Teclado](#atajos-de-teclado)
- [Plugins Incluidos](#plugins-incluidos)
- [Configuración LSP](#configuración-lsp)
- [Solución de Problemas](#solución-de-problemas)

## 🛠️ Instalación

### Requisitos Previos
- Neovim >= 0.9.0
- Git
- Node.js (para algunos language servers)
- Ripgrep (para telescope)
- Lazygit (opcional, para integración git)

### Instalación Rápida
```bash
# Hacer backup de configuración existente
mv ~/.config/nvim ~/.config/nvim.backup

# Clonar esta configuración
git clone <tu-repo> ~/.config/nvim

# Abrir Neovim (los plugins se instalarán automáticamente)
nvim
```

## ⌨️ Atajos de Teclado

### 🔑 Tecla Líder
La tecla líder está configurada como `<Espacio>`

### 📂 Navegación de Archivos

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>ff` | **Buscar Archivos** | Busca archivos en el directorio actual |
| `<leader>fr` | **Archivos Recientes** | Muestra archivos recientemente abiertos |
| `<leader>fs` | **Buscar Texto** | Busca texto en todo el proyecto (live grep) |
| `<leader>fc` | **Buscar Palabra** | Busca la palabra bajo el cursor |
| `<leader>fb` | **Buffers** | Lista de buffers abiertos |
| `<leader>fh` | **Ayuda** | Busca en la documentación de ayuda |

### 🗂️ Explorador de Archivos (NvimTree)

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>ee` | **Toggle Explorer** | Abre/cierra el explorador de archivos |
| `<leader>ef` | **Buscar Archivo** | Abre el explorer en el archivo actual |
| `<leader>ec` | **Colapsar** | Colapsa todas las carpetas |
| `<leader>er` | **Refrescar** | Refresca el explorador |

### 🎯 Harpoon (Navegación Rápida)

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>ha` | **Agregar Archivo** | Añade el archivo actual a harpoon |
| `<leader>hh` | **Menú Harpoon** | Abre el menú de archivos de harpoon |
| `<leader>h1` | **Archivo 1** | Va al primer archivo de harpoon |
| `<leader>h2` | **Archivo 2** | Va al segundo archivo de harpoon |
| `<leader>h3` | **Archivo 3** | Va al tercer archivo de harpoon |
| `<leader>h4` | **Archivo 4** | Va al cuarto archivo de harpoon |
| `<leader>hp` | **Anterior** | Archivo anterior en harpoon |
| `<leader>hn` | **Siguiente** | Siguiente archivo en harpoon |

### 📋 Gestión de Buffers

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<S-h>` | **Buffer Anterior** | Va al buffer anterior |
| `<S-l>` | **Siguiente Buffer** | Va al siguiente buffer |
| `<leader>bb` | **Alternar Buffer** | Cambia al último buffer usado |
| `<leader>\`` | **Alternar Buffer** | Cambia al último buffer usado |
| `[b` | **Buffer Anterior** | Va al buffer anterior |
| `]b` | **Siguiente Buffer** | Va al siguiente buffer |

### 🪟 Gestión de Ventanas

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>sv` | **Split Vertical** | Divide la ventana verticalmente |
| `<leader>sh` | **Split Horizontal** | Divide la ventana horizontalmente |
| `<leader>se` | **Igualar Splits** | Hace todos los splits del mismo tamaño |
| `<leader>sx` | **Cerrar Split** | Cierra el split actual |
| `<leader>sm` | **Maximizar** | Maximiza/minimiza el split actual |
| `<C-h>` | **Ventana Izquierda** | Navega a la ventana de la izquierda |
| `<C-j>` | **Ventana Abajo** | Navega a la ventana de abajo |
| `<C-k>` | **Ventana Arriba** | Navega a la ventana de arriba |
| `<C-l>` | **Ventana Derecha** | Navega a la ventana de la derecha |

### 📑 Gestión de Pestañas

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>to` | **Nueva Pestaña** | Abre una nueva pestaña |
| `<leader>tx` | **Cerrar Pestaña** | Cierra la pestaña actual |
| `<leader>tn` | **Siguiente Pestaña** | Va a la siguiente pestaña |
| `<leader>tp` | **Pestaña Anterior** | Va a la pestaña anterior |
| `<leader>tf` | **Archivo en Nueva Pestaña** | Abre el archivo actual en nueva pestaña |

### 🔧 LSP (Language Server Protocol)

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `gR` | **Referencias** | Muestra todas las referencias |
| `gD` | **Ir a Declaración** | Va a la declaración |
| `gd` | **Ir a Definición** | Va a la definición |
| `gi` | **Ir a Implementación** | Va a la implementación |
| `gt` | **Tipo de Definición** | Muestra el tipo de definición |
| `<leader>ca` | **Acciones de Código** | Muestra acciones disponibles |
| `<leader>rn` | **Renombrar** | Renombra el símbolo |
| `<leader>D` | **Diagnósticos Buffer** | Muestra diagnósticos del buffer |
| `<leader>d` | **Diagnósticos Línea** | Muestra diagnósticos de la línea |
| `[d` | **Diagnóstico Anterior** | Va al diagnóstico anterior |
| `]d` | **Siguiente Diagnóstico** | Va al siguiente diagnóstico |
| `K` | **Documentación** | Muestra documentación |
| `<leader>rs` | **Reiniciar LSP** | Reinicia el servidor LSP |

### 🐛 Debugging (nvim-dap)

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<F5>` | **Iniciar/Continuar** | Inicia o continúa el debugging |
| `<F1>` | **Step Into** | Entra en la función |
| `<F2>` | **Step Over** | Pasa por encima |
| `<F3>` | **Step Out** | Sale de la función |
| `<F7>` | **Toggle UI** | Abre/cierra la interfaz de debug |
| `<leader>db` | **Toggle Breakpoint** | Activa/desactiva breakpoint |
| `<leader>dB` | **Breakpoint Condicional** | Crea breakpoint con condición |

### 🎯 Trouble (Diagnósticos)

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>xx` | **Toggle Diagnósticos** | Abre/cierra lista de diagnósticos |
| `<leader>xX` | **Diagnósticos Buffer** | Diagnósticos solo del buffer actual |
| `<leader>cs` | **Símbolos** | Lista de símbolos |
| `<leader>cl` | **LSP Definitions** | Definiciones LSP |
| `<leader>xL` | **Location List** | Lista de ubicaciones |
| `<leader>xQ` | **Quickfix List** | Lista de quickfix |

### 🌐 Git

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>gc` | **Git Commits** | Lista de commits |
| `<leader>gfc` | **Commits del Archivo** | Commits del archivo actual |
| `<leader>gb` | **Git Branches** | Lista de ramas |
| `<leader>gs` | **Git Status** | Estado de git |
| `<leader>gg` | **Lazygit** | Abre lazygit |

#### Gitsigns (Hunks)

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `]c` | **Siguiente Hunk** | Va al siguiente cambio |
| `[c` | **Hunk Anterior** | Va al cambio anterior |
| `<leader>hs` | **Stage Hunk** | Confirma el cambio |
| `<leader>hr` | **Reset Hunk** | Resetea el cambio |
| `<leader>hS` | **Stage Buffer** | Confirma todo el buffer |
| `<leader>hu` | **Undo Stage** | Deshace stage del hunk |
| `<leader>hR` | **Reset Buffer** | Resetea todo el buffer |
| `<leader>hp` | **Preview Hunk** | Previsualiza el cambio |
| `<leader>hb` | **Blame Line** | Muestra blame de la línea |
| `<leader>tb` | **Toggle Blame** | Activa/desactiva blame |
| `<leader>hd` | **Diff Index** | Diff contra el index |
| `<leader>hD` | **Diff Last Commit** | Diff contra último commit |

### 💻 Terminal

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<C-\>` | **Toggle Terminal** | Abre/cierra terminal flotante |
| `<leader>tf` | **Terminal Flotante** | Terminal en ventana flotante |
| `<leader>th` | **Terminal Horizontal** | Terminal en split horizontal |
| `<leader>tv` | **Terminal Vertical** | Terminal en split vertical |
| `<leader>tn` | **Node REPL** | Abre REPL de Node.js |
| `<leader>tp` | **Python REPL** | Abre REPL de Python |

### 🔍 Búsqueda y Navegación

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>nh` | **No Highlight** | Quita resaltado de búsqueda |
| `n` | **Siguiente** | Siguiente resultado (centrado) |
| `N` | **Anterior** | Resultado anterior (centrado) |
| `<C-d>` | **Media Página Abajo** | Baja media página (centrado) |
| `<C-u>` | **Media Página Arriba** | Sube media página (centrado) |

### ✏️ Edición

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `jk` | **Salir Insert** | Sale del modo insertar |
| `x` | **Borrar Sin Copiar** | Borra sin guardar en registro |
| `<leader>+` | **Incrementar** | Incrementa número |
| `<leader>-` | **Decrementar** | Decrementa número |
| `J` (visual) | **Mover Abajo** | Mueve líneas seleccionadas abajo |
| `K` (visual) | **Mover Arriba** | Mueve líneas seleccionadas arriba |
| `>` (visual) | **Indentar** | Indenta manteniendo selección |
| `<` (visual) | **Des-indentar** | Des-indenta manteniendo selección |
| `p` (visual) | **Pegar Sin Copiar** | Pega sin copiar lo reemplazado |

### 🔧 Sesiones

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>qs` | **Restaurar Sesión** | Restaura sesión del directorio |
| `<leader>ql` | **Última Sesión** | Restaura la última sesión |
| `<leader>qd` | **No Guardar Sesión** | No guarda la sesión actual |

### ⚡ Acciones Rápidas

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<leader>w` | **Guardar** | Guarda el archivo |
| `<leader>q` | **Salir** | Sale de Neovim |
| `<leader>un` | **Dismiss Notifications** | Cierra todas las notificaciones |

### 🤖 AI Copilot

| Atajo | Acción | Descripción |
|-------|--------|-------------|
| `<M-l>` | **Aceptar Sugerencia** | Acepta sugerencia de Copilot |
| `<M-]>` | **Siguiente Sugerencia** | Siguiente sugerencia |
| `<M-[>` | **Sugerencia Anterior** | Sugerencia anterior |
| `<C-]>` | **Rechazar** | Rechaza sugerencia |

## 🔌 Plugins Incluidos

### Gestión de Plugins
- **lazy.nvim** - Gestor de plugins moderno y rápido

### UI/UX
- **nightfly** - Tema principal
- **catppuccin** - Tema alternativo
- **tokyonight** - Tema alternativo
- **lualine.nvim** - Barra de estado mejorada
- **bufferline.nvim** - Pestañas de buffers
- **alpha-nvim** - Pantalla de inicio
- **nvim-notify** - Notificaciones mejoradas
- **noice.nvim** - UI mejorada para mensajes
- **which-key.nvim** - Muestra atajos disponibles
- **indent-blankline.nvim** - Guías de indentación

### Navegación y Búsqueda
- **telescope.nvim** - Buscador fuzzy
- **nvim-tree.lua** - Explorador de archivos
- **harpoon** - Navegación rápida de archivos
- **trouble.nvim** - Lista de diagnósticos

### Desarrollo
- **nvim-lspconfig** - Configuración LSP
- **mason.nvim** - Instalador de language servers
- **nvim-cmp** - Autocompletado
- **nvim-treesitter** - Resaltado de sintaxis
- **gitsigns.nvim** - Integración git
- **vim-fugitive** - Comandos git avanzados
- **Comment.nvim** - Comentarios inteligentes
- **nvim-autopairs** - Cierre automático de paréntesis
- **nvim-dap** - Debugging
- **copilot.lua** - AI pair programming

### Terminal y Utilidades
- **toggleterm.nvim** - Terminal integrado
- **persistence.nvim** - Gestión de sesiones
- **vim-surround** - Manipulación de texto
- **vim-tmux-navigator** - Navegación tmux

## 🗣️ Language Servers Configurados

- **TypeScript/JavaScript** (ts_ls)
- **HTML** (html)
- **CSS** (cssls)
- **Tailwind CSS** (tailwindcss)
- **Lua** (lua_ls)
- **Python** (pyright)
- **Go** (gopls)
- **Rust** (rust_analyzer)
- **JSON** (jsonls)
- **Emmet** (emmet_ls)

## 🐛 Solución de Problemas

### Plugins no se cargan
```vim
:Lazy sync
```

### Language servers no funcionan
```vim
:Mason
```

### Rendimiento lento
```vim
:Lazy profile
```

### Verificar salud del sistema
```vim
:checkhealth
```

### Limpiar caché
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
```

## 📚 Recursos de Aprendizaje

- Presiona `<leader>` y espera para ver comandos disponibles
- `:help telescope` para uso avanzado de Telescope
- `:help lsp` para funciones de Language Server
- `:help dap` para capacidades de debugging

## 🎯 Consejos de Productividad

1. **Usa Harpoon** para navegar rápidamente entre archivos frecuentes
2. **Which-key** te mostrará todos los atajos disponibles
3. **Telescope** es tu mejor amigo para buscar archivos y texto
4. **Trouble** organiza todos los errores y diagnósticos
5. **Terminal flotante** con `<C-\>` para acceso rápido
6. **Sesiones** para restaurar tu workspace automáticamente

¡Disfruta de tu nueva configuración de Neovim! 🚀

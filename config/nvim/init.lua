-- Set leader key to space before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Import core configuration
require("David.core.options")
require("David.core.keymaps")

-- Bootstrap lazy.nvim and load plugins
require("David.lazy-setup")

-- Additional configuration
-- Habilita colores verdaderos en el terminal
vim.opt.termguicolors = true

-- Define si el tema base es oscuro o claro
vim.opt.background = "dark"

-- Configuración adicional para una mejor experiencia
-- Números de línea relativos
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentación inteligente
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Busqueda mejorada
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Mejoras visuales
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Pestañas y espacios
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Portapapeles del sistema
vim.opt.clipboard = "unnamedplus"

-- Configuración para una mejor experiencia de código
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Columna de signos siempre visible
vim.opt.signcolumn = "yes"

-- Configuración para una mejor experiencia con archivos
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Mouse support
vim.opt.mouse = "a"

-- Crear directorio para undofile si no existe
local undodir = os.getenv("HOME") .. "/.vim/undodir"
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

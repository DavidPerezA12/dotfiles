-- Set leader key to space before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Import core configuration
require("David.core.options")
require("David.core.keymaps")

-- Bootstrap lazy.nvim and load plugins
require("David.lazy-setup")

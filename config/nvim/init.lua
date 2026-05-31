-- Set leader key to space before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local deprecate = vim.deprecate
vim.deprecate = function(name, ...)
	if name == "client.is_stopped" then
		return
	end
	return deprecate(name, ...)
end

-- Import core configuration
require("David.core.options")
require("David.core.keymaps")

-- Bootstrap lazy.nvim and load plugins
require("David.lazy-setup")

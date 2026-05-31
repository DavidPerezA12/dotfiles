return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = { "ToggleTerm", "TermExec" },
		keys = {
			{ [[<c-\>]], "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
			{ "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle terminal float" },
			{ "<leader>tH", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Toggle terminal horizontal" },
			{ "<leader>tV", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Toggle terminal vertical" },
			{
				"<leader>gg",
				function()
					_LAZYGIT_TOGGLE()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>tj",
				function()
					_NODE_TOGGLE()
				end,
				desc = "Node REPL",
			},
			{
				"<leader>tp",
				function()
					_PYTHON_TOGGLE()
				end,
				desc = "Python REPL",
			},
			{
				"<leader>tu",
				function()
					_HTOP_TOGGLE()
				end,
				desc = "Htop",
			},
		},
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})

			local term_group = vim.api.nvim_create_augroup("DavidToggleTerm", { clear = true })

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.api.nvim_create_autocmd("TermOpen", {
				group = term_group,
				pattern = "term://*",
				callback = set_terminal_keymaps,
			})

			local Terminal = require("toggleterm.terminal").Terminal
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

			function _LAZYGIT_TOGGLE()
				lazygit:toggle()
			end

			local node = Terminal:new({ cmd = "node", hidden = true })

			function _NODE_TOGGLE()
				node:toggle()
			end

			local htop = Terminal:new({ cmd = "htop", hidden = true })

			function _HTOP_TOGGLE()
				htop:toggle()
			end

			local python = Terminal:new({ cmd = "python3", hidden = true })

			function _PYTHON_TOGGLE()
				python:toggle()
			end
		end,
	},
}

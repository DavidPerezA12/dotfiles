return {
	-- Vim maximizer
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
		},
	},

	-- Essential vim plugins
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{
		"inkarkat/vim-ReplaceWithRegister",
		keys = {
			{ "<leader>rm", mode = { "n", "x" }, desc = "Replace with register (motion)" },
			{ "<leader>rr", mode = "n", desc = "Replace line with register" },
		},
		config = function()
			-- Remove default conflicting mappings if present
			pcall(vim.keymap.del, "n", "gr")
			pcall(vim.keymap.del, "x", "gr")
			pcall(vim.keymap.del, "n", "gR")
			-- Recreate friendly mappings under <leader>r
			-- Operator (use a motion after it):
			vim.keymap.set({ "n", "x" }, "<leader>rm", "gr", { desc = "Replace with register (motion)" })
			-- Current line replacement shortcut
			vim.keymap.set({ "n" }, "<leader>rr", "gR", { desc = "Replace line with register" })
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
	},

	-- Better vim.ui
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = vim.opt.sessionoptions:get() },
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function()
					require("persistence").stop()
				end,
				desc = "Don't Save Current Session",
			},
		},
	},

	-- Better `vim.notify()`
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			routes = {
				{
					filter = {
						event = "notify",
						find = "client.is_stopped is deprecated",
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = false,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- Git wrapper
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
	},

	-- Detect tabstop and shiftwidth automatically
	{
		"tpope/vim-sleuth",
		event = { "BufReadPost", "BufNewFile" },
	},

	-- which-key is configured in `lua/David/plugins/which-key.lua`
}

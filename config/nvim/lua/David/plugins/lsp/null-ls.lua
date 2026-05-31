return {
	{
		"nvimtools/none-ls.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			local null_ls_utils = require("null-ls.utils")

			-- for conciseness
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics

			-- to setup format on save
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local function has_command(command)
				return vim.fn.executable(command) == 1
			end

			local function source(builtin, opts)
				if not builtin then
					return nil
				end
				if opts then
					return builtin.with(opts)
				end
				return builtin
			end

			local sources = {}
			local function add_source(builtin, opts, command)
				if command and not has_command(command) then
					return
				end
				local configured_source = source(builtin, opts)
				if configured_source then
					table.insert(sources, configured_source)
				end
			end

			add_source(formatting.prettier, { extra_filetypes = { "svelte" } }, "prettier")
			add_source(formatting.stylua, nil, "stylua")
			add_source(formatting.isort, nil, "isort")
			add_source(formatting.black, nil, "black")
			add_source(diagnostics.mypy, nil, "mypy")
			add_source(formatting.gofumpt, nil, "gofumpt")
			add_source(formatting.goimports, nil, "goimports")

			-- configure null_ls
			null_ls.setup({
				-- add package.json as identifier for root (for typescript projects)
				root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
				-- setup formatters & linters
				sources = sources,
				-- configure format on save
				on_attach = function(current_client, bufnr)
					local supports_formatting = current_client.supports_method
							and current_client:supports_method("textDocument/formatting", bufnr)
						or current_client.server_capabilities.documentFormattingProvider

					if supports_formatting then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										-- only use null-ls for formatting instead of lsp server
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}

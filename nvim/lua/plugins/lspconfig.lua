return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim"
		},
		opts = {
			inlay_hints = { enabled = true, }
		},
		config = function()
			-- Set up lspconfig.
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lspconfig = require('lspconfig')
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			mason.setup()
			mason_lspconfig.setup({
				ensure_installed = {
					"clangd",
					"pyright",
					"bashls",
					"lua_ls",
					"ruff_lsp"
				},
			})
			local ruff_lsp_on_attach = function(client, bufnr)
				if client.name == 'ruff_lsp' then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end

			lspconfig.ruff_lsp.setup({
				capabilities = capabilities,
				autostart = true
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
				autostart = true,
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
				},
			})
			lspconfig.ruff_lsp.setup({
				capabilities = capabilities,
				autostart = true,
				on_attach = ruff_lsp_on_attach,
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
				autostart = true
			})
			lspconfig.texlab.setup({
				capabilities = capabilities,
				autostart = true
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				autostart = true,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						}
					}
				}
			})
			lspconfig.bashls.setup({
				capabilities = capabilities,
				autostart = true
			})
			vim.api.nvim_exec_autocmds("FileType", {})

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the
			-- below functions
			local keyset = vim.keymap.set
			keyset('n', '<space>e', vim.diagnostic.open_float)
			keyset('n', '[d', vim.diagnostic.goto_prev)
			keyset('n', ']d', vim.diagnostic.goto_next)
			keyset('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the
					-- below functions
					local opts = { buffer = ev.buf }
					keyset('n', 'gD', vim.lsp.buf.declaration, opts)
					keyset('n', 'gd', vim.lsp.buf.definition, opts)
					keyset('n', 'K', vim.lsp.buf.hover, opts)
					keyset('n', 'gi', vim.lsp.buf.implementation, opts)
					keyset('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					keyset('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					keyset('n', '<space>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts
					)
					keyset('n', '<space>D', vim.lsp.buf.type_definition, opts)
					keyset('n', '<space>rn', vim.lsp.buf.rename, opts)
					keyset({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					keyset('n', 'gr', vim.lsp.buf.references, opts)
					keyset('n', '<space>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
		end
	},
	{
		'dgagn/diagflow.nvim',
		event = 'LspAttach',
		opts = {}
	},
}

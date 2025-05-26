vim.api.nvim_exec_autocmds("FileType", {})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the
-- below functions
local keyset = vim.keymap.set
keyset("n", "<space>e", vim.diagnostic.open_float)
keyset("n", "[d", vim.diagnostic.goto_prev)
keyset("n", "]d", vim.diagnostic.goto_next)
keyset("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the
		-- below functions
		local opts = { buffer = ev.buf }
		keyset("n", "gD", vim.lsp.buf.declaration, opts)
		keyset("n", "gd", vim.lsp.buf.definition, opts)
		keyset("n", "K", vim.lsp.buf.hover, opts)
		keyset("n", "gi", vim.lsp.buf.implementation, opts)
		keyset("n", "<space>D", vim.lsp.buf.type_definition, opts)
		keyset("n", "<space>rn", vim.lsp.buf.rename, opts)
		keyset({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		keyset("n", "gr", vim.lsp.buf.references, opts)
	end,
})

-- This is copied straight from blink

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup language servers.
vim.lsp.config("*", {
	capabilities = capabilities,
})
vim.lsp.config("pyright", {
	settings = {
		pyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
		},
	}
})
vim.lsp.enable("pyright")
vim.lsp.enable("ruff")
vim.lsp.enable("lua_ls")

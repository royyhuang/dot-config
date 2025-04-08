return {
	{
		"stevearc/conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		cmd = { "ConformInfo" },
		config = function()
			local conform = require("conform")
			conform.setup({
				log_level = vim.log.levels.DEBUG,
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					python = {
						"ruff_fix",
						"ruff_format",
						"ruff_organize_imports",
					},
					lua = { "stylua" },
					c = { "clang-format" },
					tex = { "latexindent" },
					bash = { "shellharden" },
					html = { "prettier" },
					yaml = { "prettier" },
				},
				formatters = {
					latexindent = {
						command = "/opt/homebrew/bin/latexindent",
						prepend_args = { "-m" },
					},
					ruff_organize_imports = {
						command = "ruff",
						args = {
							"check",
							"--force-exclude",
							"--select=I001",
							"--fix",
							"--exit-zero",
							"--stdin-filename",
							"$FILENAME",
							"-",
						},
						stdin = true,
						cwd = require("conform.util").root_file({
							"pyproject.toml",
							"ruff.toml",
							".ruff.toml",
						}),
					},
				},
			})
		end,
	},
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
		},
		config = function()
			require("mason-conform").setup()
		end,
	},
}

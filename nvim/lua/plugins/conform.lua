return {
	{
		"stevearc/conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					python = {
						"ruff_fix",
						"ruff_format",
						"ruff_organize_imports",
					},
					lua = { "stylua" },
					c = { "clang-format" },
					latex = { "latexindent" },
					bash = { "shellharden" },
					formatters = {
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
				},
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
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

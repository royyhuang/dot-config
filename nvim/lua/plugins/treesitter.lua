return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"python",
					"html",
					"markdown",
					"java",
				},
				sync_install = false,
				highlight = {
					enable = true,
					disable = { "latex", "tex" },
				},
				indent = { enable = true },
			})
		end,
	},
}

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		{
			's1n7ax/nvim-window-picker',
			version = '2.*',
			event = "VeryLazy",
			config = function()
				require 'window-picker'.setup({
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { 'neo-tree', "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { 'terminal', "quickfix" },
						},
					},
				})
			end,
		},
	},
	config = function ()
		require("neo-tree").setup({
			window = {
				mappings = {
					["h"] = "close_node",
					["l"] = "open_with_window_picker",
					["E"] = "vsplit_with_window_picker",
					["s"] = "split_with_window_picker"
				}
			},
			git_status = {
				symbols = {
					untracked = "?",
					deleted = "D",
					renamed = "➜",
					modified = "M",
					staged = "A"
				}
			}
		})
	end,
	keys = {
		{
			"<Space>op", "<cmd>Neotree toggle<cr>",
			mode = "n",
			desc = "ToggleNvimTree"
		},
	},
}

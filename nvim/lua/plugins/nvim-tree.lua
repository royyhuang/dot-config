local function nvim_tree_on_attach(bufnr)
  	local api = require "nvim-tree.api"
	local lib = require 'nvim-tree.lib'
	local utils = require 'nvim-tree.utils'
	local keyset = vim.keymap.set
  	local function opts(desc)
    	return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true
		}
  	end

  	-- default mappings
  	api.config.mappings.default_on_attach(bufnr)

	local function collapse_child()
		local cur_node = api.tree.get_node_under_cursor()
		if cur_node.has_children ~= nil then
			if not cur_node.has_children then  -- cursor on a opened directory
				api.node.open.edit()
			end
		end
	end

  	-- custom mappings
  	keyset('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
  	keyset('n', '?',     api.tree.toggle_help,           opts('Help'))
  	keyset('n', 'l',     api.node.open.edit,             opts('Open'))
	keyset("n", "h", 	 collapse_child,        		 opts("Close"))
  	keyset('n', 'E',     api.node.open.vertical,         opts('Open vertical'))
  	keyset('n', 's',     api.node.open.horizontal,       opts('Open horizontal'))
  	keyset('n', '<CR>',  api.tree.change_root_to_node,   opts('CD into node'))
  	keyset('n', '<BS>',  api.tree.change_root_to_parent, opts('CD into parent'))
end

return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			'kyazdani42/nvim-web-devicons'
		},
		keys = {
			{
				"<Space>op", "<cmd>NvimTreeToggle<cr>",
				mode = "n",
				desc = "ToggleNvimTree"
			},
		},
		config = function ()
			local nvim_tree = require("nvim-tree")
			nvim_tree.setup({
				sync_root_with_cwd = true,
				update_cwd = true,
				on_attach = nvim_tree_on_attach,
				sort = { sorter = "case_sensitive", },
				view = { width = 30, },
				renderer = { group_empty = true, },
				filters = { dotfiles = true, },
				update_focused_file = {
					enable = true,
					update_root = true,
					ignore_list = {},
				},
			})
		end,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
		  	"nvim-lua/plenary.nvim",
		  	"nvim-tree/nvim-tree.lua",
		},
		config = function()
		  	require("lsp-file-operations").setup()
		end,
	}
}

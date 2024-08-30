
local function nvim_tree_on_attach(bufnr)
  	local api = require "nvim-tree.api"
	local lib = require 'nvim-tree.lib'
	local utils = require 'nvim-tree.utils'
	local keyset = vim.keymap.set
  	local function get_opts(desc)
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
  	keyset('n', '<C-t>', api.tree.change_root_to_parent, get_opts('Up'))
  	keyset('n', '?',     api.tree.toggle_help,           get_opts('Help'))
  	keyset('n', 'l',     api.node.open.edit,             get_opts('Open'))
	keyset("n", "h", 	 collapse_child,        		 get_opts("Close"))
  	keyset('n', 'E',     api.node.open.vertical,         get_opts('Open vertical'))
  	keyset('n', 's',     api.node.open.horizontal,       get_opts('Open horizontal'))
  	keyset('n', '<CR>',  api.tree.change_root_to_node,   get_opts('CD into node'))
  	keyset('n', '<BS>',  api.tree.change_root_to_parent, get_opts('CD into parent'))
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
				update_cwd = true,
				on_attach = nvim_tree_on_attach,
				sort = { sorter = "case_sensitive", },
				view = { width = 30, },
				renderer = {
					highlight_git = true,
					group_empty = true,
					icons = {
						webdev_colors = true,
						git_placement = "after",
						modified_placement = "after",
						glyphs = {
							git = {
								-- Git style symbols
								unstaged  = "M",
								staged    = "A",
								unmerged  = "M",
								renamed   = "R",
								untracked = "U",
								deleted   = "D",
								ignored   = ""
							}
						},
					},
				},
				filters = { dotfiles = true, },
				update_focused_file = {
					enable = true,
					update_root = true,
					ignore_list = {},
				},
			})
			vim.cmd([[
				:hi link NvimTreeGitDeletedIcon   	ErrorMsg
				:hi link NvimTreeGitNewIcon   		MoreMsg
				:hi link NvimTreeGitDirtyIcon       Directory 
				:hi link NvimTreeFolderName			NvimTreeNormal              
				:hi link NvimTreeEmptyFolderName    NvimTreeNormal 
				:hi link NvimTreeOpenedFolderName   NvimTreeNormal     
				:hi link NvimTreeSymlinkFolderName  NvimTreeNormal    
			]])
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

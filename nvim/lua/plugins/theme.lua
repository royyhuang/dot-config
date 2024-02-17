return {
	{
		'marko-cerovac/material.nvim',
		config = function ()
			require('material').setup({
			  lualine_style = 'stealth', -- the stealth style
			  plugins = {
				"telescope"
			  }
			})
			vim.cmd("colorscheme material")
		end
	},
  	'kyazdani42/nvim-web-devicons',
	{
		'nvim-lualine/lualine.nvim',
		config = function ()
			require('lualine').setup {
			  	options = {
					theme = 'material',
			  		section_separators = '',
			  		component_separators = '',
			  	}
			}
		end
	},
	{
		'alvarosevilla95/luatab.nvim',
		config = function ()
			require('luatab').setup {}
		end
	},
	{
		'edkolev/tmuxline.vim',
		config = function ()
			-- tmuxline configs
			vim.g.tmuxline_powerline_separators = 0
			vim.g.tmuxline_theme = "vim_statusline_1"
			vim.cmd [[
			let g:tmuxline_preset = {
			  	\ 'a': '[#S]',
			  	\ 'win': '#I:#W#F',
			  	\ 'cwin': '#I:#W#F',
			  	\ 'z': '%H:%M %b-%d-%y',
			  	\ 'options': {
			  	\   'status-justify': 'left'}
			  	\}
			]]
		end
	},
  	'airblade/vim-gitgutter',
  	{
  		'VonHeikemen/fine-cmdline.nvim',
  		dependencies = { 'MunifTanjim/nui.nvim' }
  	}
}

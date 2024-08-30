return {
	{
		'voldikss/vim-floaterm',
		config = function ()
			-- vim-floaterm keybindings
			local keyset = vim.keymap.set
			keyset("n", "<C-t>", ":FloatermToggle<cr>")
			keyset("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<cr>")
		end
	},
  	'easymotion/vim-easymotion',
	{
    	'windwp/nvim-autopairs',
    	event = "InsertEnter",
    	opts = {
			disable_filetype = { "TelescopePrompt" , "vim" },
		} -- this is equalent to setup({}) function
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		},
		lazy = false,
	}
}

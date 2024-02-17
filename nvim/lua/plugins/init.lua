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
  	'christoomey/vim-tmux-navigator',
}

return {
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_compiler_latexmk = {
				continuous = 0,
			}
			local keyset = vim.keymap.set
			local opt = { noremap = true, silent = true }
			keyset("n", "<C-c><C-a>", ":VimtexCompile<CR>", opt)
			keyset("n", "<C-c><C-v>", ":VimtexView<CR>", opt)
		end,
	},
}

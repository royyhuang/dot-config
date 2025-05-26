-- General vim options
vim.opt.encoding = "utf-8"
vim.opt.colorcolumn = "80"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.background = "dark"
vim.opt.backspace = "2"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.updatetime = 100
vim.opt.shortmess = "c"
vim.opt.cursorline = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("syntax enable")
vim.cmd("filetype indent on")
vim.cmd("filetype on")

vim.api.nvim_create_augroup("texFileType", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	command = "setlocal tabstop=2 shiftwidth=2 expandtab",
})

-- General vim keybindings
local keyset = vim.keymap.set
keyset("n", "k", "(v:count == 0 ? 'gk' : 'k')", { expr = true })
keyset("n", "j", "(v:count == 0 ? 'gj' : 'j')", { expr = true })
keyset("i", "jj", "<ESC>")
keyset("n", "<space>bn", ":bn<cr>")
keyset("n", "<space>bp", ":b#<cr>")
keyset("n", "<space>bk", ":bp|bd #<cr>")

require("config.lazy")
require("config.lsp")

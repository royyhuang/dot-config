-- General vim options
vim.opt.encoding="utf-8"
vim.opt.colorcolumn="80"
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
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("syntax enable")
vim.cmd("filetype indent on")

-- -- Define an autocommand group and autocommands in Lua
-- local api = vim.api
--
-- -- Create or clear the autocommand group
-- local group = api.nvim_create_augroup('MyColorScheme', { clear = true })
--
-- -- Set up autocommands within the group
-- api.nvim_create_autocmd('ColorScheme', {
--     group = group,
--     pattern = '*',
--     callback = function()
-- 		vim.cmd([[
--  			hi Normal guibg=NONE ctermbg=NONE
-- 			hi LineNr guibg=NONE ctermbg=NONE
-- 			hi Folded guibg=NONE ctermbg=NONE
-- 			hi NonText guibg=NONE ctermbg=NONE
-- 			hi SpecialKey guibg=NONE ctermbg=NONE
-- 			hi VertSplit guibg=NONE ctermbg=NONE
-- 			hi EndOfBuffer guibg=NONE ctermbg=NONE
-- 		]])
--     end
-- })

-- General vim keybindings
local keyset = vim.keymap.set
keyset("n", "k", "(v:count == 0 ? 'gk' : 'k')", {expr = true})
keyset("n", "j", "(v:count == 0 ? 'gj' : 'j')", {expr = true})
keyset("i", "jj", "<ESC>")
keyset("n", "<space>bn", ":bn<cr>")
keyset("n", "<space>bp", ":bp<cr>")
keyset("n", "<space>bk", ":bp|bd #<cr>")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

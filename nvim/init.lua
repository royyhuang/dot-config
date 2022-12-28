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
vim.cmd "syntax enable"
vim.cmd "filetype indent on"

-- general vim keybindings
local keyset = vim.keymap.set
keyset("n", "k", "(v:count == 0 ? 'gk' : 'k')", {expr = true})
keyset("n", "j", "(v:count == 0 ? 'gj' : 'j')", {expr = true})
keyset("i", "jj", "<ESC>")
keyset("n", "<space>bn", ":bn<cr>")
keyset("n", "<space>bp", ":bp<cr>")
keyset("n", "<space>bk", ":bp|bd #<cr>")

-- Packer packages
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here
  use 'marko-cerovac/material.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'alvarosevilla95/luatab.nvim'
  use {
	  'nvim-treesitter/nvim-treesitter',
  	  branch = 'master',
	  run = ':TSUpdate'
  }
  use {
    'neoclide/coc.nvim',
    branch = 'release',
  }
  use 'christoomey/vim-tmux-navigator'
  use 'voldikss/vim-floaterm'
  use 'edkolev/tmuxline.vim'
  use 'easymotion/vim-easymotion'
  use 'airblade/vim-gitgutter'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
 use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
 use 'lewis6991/impatient.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

require("impatient")

-- coc keybindings
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
keyset("n", "<space>op", ":CocCommand explorer<cr>")
keyset("n", "<space>rf", "<Plug>(coc-refractor)")
keyset("n", "<space>ca", "<Plug>(coc-codeaction-cursor)")
keyset("x", "<space>ca", "<Plug>(coc-codeaction-cursor)")
keyset("i", "<TAB>",'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
-- Change the coc-completion window color scheme
vim.api.nvim_create_autocmd(
	{"VimEnter", "ColorScheme"},
	{pattern = "*", command = "hi! link CocMenuSel PMenuSel"})
vim.api.nvim_create_autocmd(
	{"VimEnter", "ColorScheme"},
	{pattern = "*", command = "hi! link CocSearch Identifier"})
vim.api.nvim_create_autocmd(
	{"VimEnter", "ColorScheme"},
	{pattern = "*", command = "hi CocFloating guifg=#b0bec5 guibg=#355058"})

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "python", "cpp", "bash", "fish", "lua"},
  highlight = {
	enable = true
  },
}

require('material').setup({
	lualine_style = 'stealth', -- the stealth style
	plugins = {
		"telescope"
	}
})
vim.cmd "colorscheme material"

require('lualine').setup {
  options = {
    theme = 'material',
	section_separators = '',
	component_separators = '',
  }
}

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

require('telescope').setup{
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
-- telescope keybindings
local builtin = require('telescope.builtin')
keyset("n", "<space>.", builtin.find_files, {})
keyset("n", "<space>fj", builtin.live_grep, {})
keyset("n", "<space>bi", builtin.buffers, {})
keyset("n", "<space>fh", builtin.help_tags, {})

require('luatab').setup {}

-- vim-floaterm keybindings
keyset("n", "<C-t>", ":FloatermToggle<cr>")
keyset("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<cr>")


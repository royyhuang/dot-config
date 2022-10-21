filetype plugin indent on
filetype indent on
syntax enable
set encoding=utf-8
set colorcolumn=80
set tabstop=4 shiftwidth=4
set noshowmode showcmd laststatus=3
set splitbelow splitright
set background=dark
set backspace=2
set number relativenumber
set clipboard+=unnamedplus
set mouse=a
set showtabline=2

inoremap jj <ESC>
nmap <expr> k (v:count == 0 ? 'gk' : 'k')
nmap <expr> j (v:count == 0 ? 'gj' : 'j')
nmap H ^
nmap L $
nmap <leader> t m :TableModeToggle

autocmd FileType org setlocal shiftwidth=2 softtabstop=2 expandtab nofoldenable conceallevel=2 nowrap
autocmd FileType tex setlocal shiftwidth=4 softtabstop=4 expandtab nofoldenable


" floaterm
let g:floaterm_keymap_toggle = '<C-t>'


" Coc.nvim
set hidden nobackup nowritebackup updatetime=100 shortmess+=c signcolumn=yes
highlight clear SignColumn

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" GoTo ccde navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <C-y>  :<C-u>CocList -A --normal yank<cr>
map <C-e> :CocCommand explorer<CR>
nmap <space>rf <Plug>(coc-refactor)
nmap <space>a :CocAction<cr>
xnoremap <space>a :CocAction<cr>

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"


" visual config
set termguicolors
set fillchars+=vert:│
colorscheme material
let g:material_style = "oceanic"
let g:tmuxline_preset = {
        \ 'a': '[#S]',
        \ 'win': '#I:#W#F',
        \ 'cwin': '#I:#W#F',
        \ 'z': '%H:%M %b-%d-%y',
        \ 'options': {
        \'status-justify': 'left'}
        \}
" orgmode headline colorscheme
" hi OrgHeadlineLevel1 guibg=None guifg=#b80059 gui=bold
" hi OrgHeadlineLevel2 guibg=None guifg=#36a2e5 gui=bold
" hi OrgHeadlineLevel3 guibg=None guifg=#e09f3e gui=bold
" hi OrgHeadlineLevel4 guibg=None guifg=#9d8189 gui=bold


" easymotion
nmap s <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
let g:EasyMotion_do_mapping = 0 " Disable default mappings


" firenvim
" function! ChangeGUIFont()
"   if exists('g:started_by_firenvim')
"     set guifont=JetBrainsMono_Nerd_Font:h17
"     set laststatus=0
"   endif
" endfunction
" au UIEnter * call timer_start(100, {tid -> execute('call ChangeGUIFont()')})
" let g:timer_started = v:false
" function! My_Write(timer) abort
"   let g:timer_started = v:false
"   write
" endfunction


"telescope
nnoremap <space>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <space>fj <cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <space>fb <cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <space>fh <cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown({}))<cr>


lua << EOF
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
  use 'dhruvasagar/vim-table-mode'
  use 'marko-cerovac/material.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  -- use 'nvim-orgmode/orgmode
  -- use 'alvarosevilla95/luatab.nvim'
  -- use 'nvim-treesitter/nvim-treesitter'
  -- use 'lukas-reineke/headlines.nvim'
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
  use 'famiu/bufdelete.nvim'
  
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd [[highlight Headline1 guibg=#320018]]
vim.cmd [[highlight Headline2 guibg=#092d43]]
vim.cmd [[highlight Headline3 guibg=#422c0b]]
vim.cmd [[highlight Headline4 guibg=#2c2224]]
-- require("headlines").setup {
--   org = {
--     source_pattern_start = "#%+[bB][eE][gG][iI][nN]_[sS][rR][cC]",
--     source_pattern_end = "#%+[eE][nN][dD]_[sS][rR][cC]",
--     dash_pattern = "^-----+$",
--     headline_pattern = "^%*+",
-- 	headline_highlights = {
-- 	  "Headline1", "Headline2", "Headline3", "Headline4"},
-- 	-- headline_highlights = false,
--     -- codeblock_highlight = "CodeBlock",
--     codeblock_highlight = false,
--     dash_highlight = "Dash",
--     dash_string = "―",
--     fat_headlines = false,
--     },
-- }

-- require('orgmode').setup_ts_grammar()
-- 
-- require'nvim-treesitter.configs'.setup {
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = {'org'},
--   },
--   ensure_installed = {'python', 'c', 'go'}, -- Or run :TSUpdate org
-- }

-- require('orgmode').setup {
--   org_agenda_files = {'~/my-orgs/**/*', '~/Documents/uc-cs/*','~/org/**/*'},
--   org_default_notes_file = '~/org/refile.org',
--   org_hide_emphasis_markers = true,
--   org_todo_keywords = {'TODO', 'DOING', '|', 'DONE', 'CANCELLED'},
--   org_todo_keyword_faces = {
--     DOING = ':foreground cyan :weight bold',
--     DELEGATED = ':background #FFFFFF :slant italic :underline on',
--   },
--   mappings = {
--     org = {
--       org_toggle_checkbox = "<Leader><Space>",
--     },
--   },
-- }

require('material').setup({
	lualine_style = 'stealth', -- the stealth style
	italics = {
		comments = true, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false -- Enable italic variables
	},
})

require('lualine').setup {
  options = {
    theme = 'material',
	section_separators = '',
	component_separators = '',
  }
}

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

-- require('luatab').setup {}
EOF

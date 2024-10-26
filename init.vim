syntax on

set number
set relativenumber
set ruler
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set modelines=0
set backspace=indent,eol,start
set nowrap
set hlsearch
set incsearch
set ic
set smartcase
set encoding=UTF-8
set completeopt-=preview 
set clipboard=unnamedplus
set t_Co=256

" Убрат фон
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
autocmd vimenter * hi LineNr guibg=NONE ctermbg=NONE
autocmd vimenter * hi SignColumn guibg=NONE ctermbg=NONE

nnoremap <F8> :TagbarToggle<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-a>a gg0"+yG
nnoremap da :%d<CR>
nnoremap yG "+yG
nnoremap y "+y
nnoremap g0 gg0
nnoremap ; a();<C-c>hi
nnoremap <F2> :lua vim.lsp.buf.rename()<CR>
nnoremap <CR> o<C-c>
nnoremap <C-l>c :%d<CR>a#include<Space><stdio.h><CR><CR>int<Space>main()<Space>{<CR><CR>return<Space>0;<CR>}<CR><CR><C-c>3Go
nnoremap <C-l>cs :%d<CR>ainternal<Space>class<Space>Program<CR>{<CR>static<Space>void<Space>Main()<CR>{<CR>}<CR>}<CR><CR><C-c>4Go
nnoremap <C-/> gcc
vmap <C-/> gc

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-commentary'

Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'terryma/vim-multiple-cursors'
Plug 'https://github.com/preservim/tagbar'

Plug 'jiangmiao/auto-pairs' "авто закрытие брекетов и т.п.
Plug 'matze/vim-move' "перемещение строки
Plug 'numToStr/Comment.nvim' "комменты

Plug 'neovim/nvim-lspconfig'       "поддержка языков
Plug 'hrsh7th/nvim-cmp'           "автодополнение
Plug 'hrsh7th/cmp-nvim-lsp'         "иcточник автодополнения для LSP
Plug 'hrsh7th/cmp-buffer'         "источник автодополнения для буфера
Plug 'hrsh7th/cmp-path'           "источник автодополнения для файловых путей
Plug 'williamboman/mason.nvim'       "управление серверами LSP
Plug 'williamboman/mason-lspconfig.nvim' "интеграция с nvim-lspconfig
" Plug 'dense-analysis/ale'

Plug 'morhetz/gruvbox' " тема

call plug#end()

colorscheme gruvbox

lua << EOF
  local lspconfig = require'lspconfig'
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-e>'] = cmp.mapping.close(),

      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
    }
  })

  -- Сервера LSP
  require'lspconfig'.pyright.setup{}  -- Python
  require'lspconfig'.clangd.setup{}  -- C, C++ 
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "clangd" },
  })
  require('Comment').setup({
    toggler = {
        line = '//',  -- Комментарий для строки
        block = '/*', -- Комментарий для блока
    },
    opleader = {
        line = '//',  -- Оператор для выделенной строки
        block = '/*', -- Оператор для блока
    },
    extra = {
        above = '//', -- Комментарий выше блока
        below = '//', -- Комментарий ниже блока
    },
})
EOF



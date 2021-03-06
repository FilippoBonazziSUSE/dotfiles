" Auto-install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

" Plugins
call plug#begin()
" git indicator in editor
Plug 'airblade/vim-gitgutter'

" Gruvbox theme
Plug 'sainnhe/gruvbox-material'

" Status bar
Plug 'itchyny/lightline.vim'

" Trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" SELinux syntax
Plug 'lzap/vim-selinux'

" LSP config
Plug 'neovim/nvim-lspconfig'

" Sway syntax
Plug 'jamespeapen/swayconfig.vim'

" neomutt syntax
Plug 'neomutt/neomutt.vim'

" Trouble list
Plug 'folke/trouble.nvim'

" LSP auto colors
Plug 'folke/lsp-colors.nvim'

" Surround
Plug 'tpope/vim-surround'

call plug#end()
"""""""""""""""""""""""""""""""""""""""

" Set terminal title
set title

" always show the status bar
set laststatus=2

" turn on line numbering
set number

" mouse
set mouse=a

" Use true colors
if (has("termguicolors"))
  set termguicolors
endif

" color scheme
colorscheme gruvbox-material

" Color trailing whitespace with theme color
" let g:better_whitespace_guicolor=gruvbox_material#get_palette('medium', 'material').red[0]

" lightline
" Set colorscheme to match
" Add modified icon to inactive buffers
let g:lightline = {
      \	'colorscheme' : 'gruvbox_material',
      \	'inactive': {'left': [['filename'], ['modified']]},
      \ }
" Do not show additional mode info outside of status line
set noshowmode

" Enable Omnicompletion
set omnifunc=syntaxcomplete#Complete

" Be smart with upper and lowercase when searching
set ignorecase
set smartcase

" Incremental search
set incsearch

" Folding
set foldmethod=syntax
set foldlevelstart=99

" Space toggles folds
nnoremap <space> za

" More natural split opening
set splitbelow
set splitright

" Better completion menu
set completeopt=longest,menuone,preview

" Better file completion menu
set wildmode=longest,list,full

" Better word wrapping
set lbr

" LSP config
lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.remark_ls.setup{}
" LSP mappings (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

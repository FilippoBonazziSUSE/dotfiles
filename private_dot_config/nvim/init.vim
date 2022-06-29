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

call plug#end()
"""""""""""""""""""""""""""""""""""""""

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

" Color trailing whitespace
let g:better_whitespace_guicolor=gruvbox_material#get_palette('medium', 'material').red[0]

" lightline
let g:lightline = {'colorscheme' : 'gruvbox_material'}
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
" LSP mappings (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

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
Plug 'nvim-lualine/lualine.nvim'

" Icons for lualine
Plug 'nvim-tree/nvim-web-devicons'

" Trailing whitespace
Plug 'ntpeters/vim-better-whitespace'

" SELinux syntax
Plug 'lzap/vim-selinux'

" LSP config
Plug 'neovim/nvim-lspconfig'

" neomutt syntax
Plug 'neomutt/neomutt.vim'

" CSS syntax
Plug 'amadeus/vim-css'

" CSS colors
Plug 'brenoprata10/nvim-highlight-colors'

" Trouble list
Plug 'folke/trouble.nvim'

" Surround
" cs"'
" ds'
Plug 'tpope/vim-surround'

" Commentary
" Use gcc to comment out a line (takes a count), gc to comment out the target
" of a motion (for example, gcap to comment out a paragraph), gc in visual
" mode to comment out the selection, and gc in operator pending mode to target
" a comment. You can also use it as a command, either with a range like
" :7,17Commentary, or as part of a :global invocation like with
" :g/TODO/Commentary
Plug 'tpope/vim-commentary'

" speeddating
" Use ^a ^x with dates
Plug 'tpope/vim-speeddating'

" Sleuth
" Autodetect buffer options from current file, similar files, files in tree...
Plug 'tpope/vim-sleuth'

" Eunuch
" UNIX helpers, shebang detection, chmod +x
Plug 'tpope/vim-eunuch'

" Endwise
" end structures automatically (if, do, ...)
Plug 'tpope/vim-endwise'

" Characterize
" ga shows character representation
Plug 'tpope/vim-characterize'

" mbsync configuration syntax
Plug 'Fymyte/mbsync.vim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()
"""""""""""""""""""""""""""""""""""""""

" Set terminal title
set title

" turn on line numbering
set number

" mouse
set mouse=a

" Use true colors
if (has("termguicolors"))
  set termguicolors
endif

" Highlight colors in all filetypes
lua require('nvim-highlight-colors').setup {render = 'background'}

" Configure Trouble
lua require('trouble').setup {cmd = 'Trouble'}

" color scheme
colorscheme gruvbox-material

" Color trailing whitespace with theme color
" let g:better_whitespace_guicolor=gruvbox_material#get_palette('medium', 'material').red[0]

" Show trailing whitespace in Markdown files
" Redefine built-in blacklist, removing markdown
let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive']

" Lualine setup
lua require('lualine-conf')

" always show the status bar
set laststatus=2

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
lua require('lspconfig').clangd.setup{}
lua require('lspconfig').bashls.setup{}
lua require('lspconfig').vimls.setup{}
" Broken right now due to missing remark
" lua require('lspconfig').remark_ls.setup{}
" LSP mappings (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" PYLSP setup
lua require('lspconfig').pylsp.setup {settings = {pylsp = {plugins = {autopep8 = {enabled = false}, yapf = {enabled = true}}}}}

" Treesitter setup
lua require("treesitter")

com! CheckHighlightUnderCursor echo {l,c,n ->
      \   'hi<'    . synIDattr(synID(l, c, 1), n)             . '> '
      \  .'trans<' . synIDattr(synID(l, c, 0), n)             . '> '
      \  .'lo<'    . synIDattr(synIDtrans(synID(l, c, 1)), n) . '> '
      \ }(line("."), col("."), "name")

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  if mode() == "v"
    let [line_start, column_start] = getpos("v")[1:2]
    let [line_end, column_end] = getpos(".")[1:2]
  else
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
  endif
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

" Auto copy visual selection to primary clipboard
augroup visual_clipboard
  autocmd!
  autocmd ModeChanged *:[vV\x16]* let @* = s:get_visual_selection()
  autocmd ModeChanged [vV\x16]*:* let @* = s:get_visual_selection()
augroup END

" Automatically resize splits to equal size when resizing window
augroup autoresize_splits
  autocmd VimResized * wincmd =
augroup END

" Show all whitespace with :set list
set listchars=eol:¬,tab:-->,trail:~,extends:>,precedes:<,space:␣

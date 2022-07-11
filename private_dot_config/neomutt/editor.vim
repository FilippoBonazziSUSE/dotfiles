" NVIM configuration file as neomutt editor

" Include main NVIM configuration file
source ~/.config/nvim/init.vim
" Include LDAP email completion script
source ~/.config/nvim/ldap_complete.vim

" Specific settings for neomutt editing
set textwidth=80
set colorcolumn=80

" Enable spell check
set spell
set spelllang=en_gb,it

augroup startup
	" Position the cursor on the first empty line at startup
	" (skip email headers)
	autocmd VimEnter * /^$/ | noh
	" Disable spell checking in email signature
	autocmd VimEnter * syn region mailSignature contains=@NoSpell start="^--\s$" end="^$" end="^\(> \?\)\+"me=s-1
augroup END

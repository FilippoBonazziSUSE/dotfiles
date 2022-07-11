" Name:		ldap_complete.vim
" Copyright:	Copyright (C) 2022 Filippo Bonazzi <filippo.bonazzi@suse.com>
"		Based on ldbq.vim by Stefano Zacchiroli <zack@bononia.it>
" License:	GNU GPL version 3 or above
" Summary:	Autocomplete email addresses in Vim from LDAP

" query mutt_addressbook with a query string and return a list of strings
" [ 'Full Name <full.name@example.com>', ... ]
function! MuttQuery(conf,query)
  let output = system("mutt_addressbook -C '" . a:conf . "' '" . a:query . "'")
  let results = []
  for line in split(output, "\n")[1:] " skip first line (mutt_addressbook boilerplate)
    let fields = split(line, "\t")
    call add(results, fields[1] . " <" . fields[0] . ">")
  endfor
  return results
endfunction

" Complete current word using MuttQuery
function! CompleteAddr(findstart, query)
  if a:findstart
    " Locate the start of the word to match
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\a'
      let start -= 1
    endwhile
    return start
  else
    " Query LDAP for matching addresses
    return MuttQuery(g:ldap_conf, a:query)
  endif
endfun

" Configure completefunc
set completefunc=CompleteAddr

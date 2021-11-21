" syntax match todoCheckbox '\v.*\[\ \]'hs=e-2 conceal cchar=
" syntax match todoCheckbox '\v.*\[X\]'hs=e-2 conceal cchar=

syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=柳

setlocal conceallevel=2
hi Conceal guibg=NONE

setlocal cole=1

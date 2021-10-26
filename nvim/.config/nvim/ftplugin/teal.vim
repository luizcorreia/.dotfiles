func! s:format()
    let l:view = winsaveview()
    normal gqae
    call winrestview(l:view)
endfunc

autocmd BufWritePre <buffer> call s:format()

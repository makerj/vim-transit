function! s:translate()
    echo "Hello World!"
endfunction

command! Translate call <SID>translate()

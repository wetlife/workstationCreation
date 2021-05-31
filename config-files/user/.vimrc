"set t_Co=256 " set 256 colors
"set whichwrap+=<,>,h,l,[,] " allow left/right nav. across newlines
set number " enable line-numbering
set laststatus=2 " always show status
filetype on
filetype indent on " indent based on filetype
set pastetoggle=<F2> " toggle literal pasting without automatic indentation
syntax enable " color syntax
set tabstop=4 shiftwidth=4 expandtab
colorscheme zellner
set background=dark
" disable highlighting implemented below with :hi clear Comment
highlight Comment ctermbg=darkgray ctermfg=lightblue
"runtime macros/matchit.vim " jump between html tags
""""""" BEGIN WRAPPING BEHAVIOR
set breakindent " match indentation of wrapped line with its continuation
set linebreak " turn on line-wrapping without breaking words
set briopt=shift:2,sbr "  indent wrapped lines by specified number of spaces
set showbreak=>> " indicate wrapped lines with this string
""""""" END WRAPPING BEHAVIOR
autocmd Filetype gitcommit setlocal spell textwidth=72 " check spelling and automate wrapping at 72 chars when editing git commit messages
autocmd Filetype make setlocal noet " makefiles indent with tabs
" TODO FIXME CREATE FILETYPE-DEPENDENT-EXECUTION-HOTKEYS
" run `npm start` and send STDOUT and STDERR to ./logfile
map <F1> :!make<CR>
map <F3> :!go run %<CR>
map <silent> <F4> :!date>>logfile && npm start &>>logfile &<CR>
" WINDOWS: view current buffer in Firefox by pressing F7:
"map <silent> <F5> :!start file://C:/Users/KThom02/AppData/Local/Firefox/Developer\ Edition/firefox.exe %:p<CR>
" WINDOWS: view current buffer in Chrome by pressing F6:
"map <silent> <F6> :!start file://C:/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe %:p<CR>

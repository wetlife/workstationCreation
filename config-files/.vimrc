set t_Co=256 " set 256 colors
set whichwrap+=<,>,h,l,[,] " allow left/right nav. across newlines
set number " enable line-numbering
"execute pathogen#infect() " load pathogen's extensions
set laststatus=2 " always show status
"filetype indent off " indent based on filetype
set pastetoggle=<F2> " toggle a literal pasting without automatic indentation
syntax enable " color syntax
"set background=dark " set a dark background
"colorscheme wombat256mod
"colorscheme monokai
colorscheme PaperColor
"runtime macros/matchit.vim " jump between html tags
set breakindent " match indentation of wrapped line with its continuation
set linebreak " turn on line-wrapping without breaking words
set briopt=shift:2 " indent wrapped lines by specified number of spaces
autocmd Filetype gitcommit setlocal spell textwidth=72 " check spelling and automate wrapping at 72 chars when editing git commit messages
" view current buffer in Firefox by pressing F5:
nnoremap <silent> <F5> :!start file://C:/Users/KThom02/AppData/Local/Firefox/Developer\ Edition/firefox.exe %:p<CR>
" view current buffer in Chrome by pressing F6:
nnoremap <silent> <F6> :!start file://C:/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe %:p<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/bundle/jshint2.vim/
" integrate eslint using syntastic via vim-plug
" set default syntastic-settings recommended at
" https://medium.com/@hpux/vim-and-eslint-16fa08cc580f
"COMMENTEDset statusline+=%#warningmsg#
"COMMENTEDset statusline+=%{SyntasticStatuslineFlag()}
"COMMENTEDset statusline+=%*
"COMMENTEDlet g:syntastic_always_populate_loc_list = 1
"COMMENTEDlet g:syntastic_auto_loc_list = 1
"COMMENTED"let g:syntastic_check_on_open = 1
"COMMENTEDlet g:syntastic_check_on_wq = 0
"COMMENTEDlet g:syntastic_javascript_checkers = ['eslint', 'eslint-plugin-html']
"COMMENTEDlet g:syntastic_javascript_eslint_exe = 'npm run lint --'
call plug#begin('~/.vim/plugins_by_vimplug')
"Plug 'scrooloose/syntastic'
Plug 'mhinz/vim-signify'
call plug#end()
"autocmd FileType html
"  \  let b:syntastic_checkers = ['eslint'] |
"  \  let b:syntastic_html_eslint_args = ['--plugin', 'html'] 
"filetype plugin indent on
set tabstop=2 " show existing tab with width of 2 spaces
set shiftwidth=2 " when indenting with '>', use 2 spaces width
set expandtab " insert 2 spaces when tab is pressed

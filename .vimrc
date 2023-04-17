""""""""""""""""""""""""""""""""""""""""
"
" A very basic .vimrc for personnal purposes only.
" Comments have been inspired by https://github.com/amix/vimrc
"
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""
" filetype detections
filetype on
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Remap leader key
let mapleader = ","

" Enable mouse
set mouse=n

" Scroll off
set scrolloff=15

" Theme color
color desert

""""""""""""""""""""""""""""""""""""""""
" => UI
""""""""""""""""""""""""""""""""""""""""
" Always show current position
set ruler

" Show line numbers
set number

" Show relative line numbers
"set relativenumber

" Highlight search results
set hlsearch

" Start searching when typing
set incsearch

" Underline current search in visual mode
highlight incsearch cterm=underline

" Automatic word wrapping
"set textwidth=79

" Show matching brackets when cursor is over them
set showmatch

" Show invisible characters
set list listchars=nbsp:·,tab:¬·,trail:¤,extends:▶,precedes:◀

""""""""""""""""""""""""""""""""""""""""
" => Folding
""""""""""""""""""""""""""""""""""""""""
"set foldmethod=indent

""""""""""""""""""""""""""""""""""""""""
" => Colors and fonts
""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax on

" Show extra-whitespaces in red
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Show a gutter on the right at 100 chars
highlight ColorColumn ctermbg=0 guibg=lightgrey
set colorcolumn=100

""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in Git
"set nobackup
"set nowb
"set noswapfile

""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""
" 1 tab = 4 spaces by default
set tabstop=4
set shiftwidth=4

autocmd FileType ada set tabstop=3
autocmd FileType ada set shiftwidth=3
autocmd FileType ada set expandtab

autocmd FileType c set tabstop=2
autocmd FileType c set shiftwidth=2
autocmd FileType c set expandtab

" Use tabs or spaces smartly
set smarttab

" TODO: add a comment
set formatoptions+=j
set nojoinspaces

""""""""""""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

""""""""""""""""""""""""""""""""""""""""
" => Moving around
""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""
" => Splitting
""""""""""""""""""""""""""""""""""""""""
" Split navigation with ctrl+h/j/k/l
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural splitting
set splitbelow
set splitright

""""""""""""""""""""""""""""""""""""""""
" => Useful mappings
""""""""""""""""""""""""""""""""""""""""
" Make jk working as <Esc> key
imap jk <Esc>

" Make capital U working as ctrl+R (so it reverses u)
nnoremap U <C-R>

" Insert blank lines without entering into insert mode with leader+o/O
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j

" No highlight shortcut
nnoremap <silent> <leader><space> :nohl<CR>

" Go to start of the command line with ctrl-A as in standard terminal
cmap <C-A> <home>

" Format shortcut
nnoremap <silent> <F2> :w<CR>:mark a<CR>:%!make format-file FILE=%<CR>:'a<CR>
nnoremap <silent> <F3> :w<CR>:mark a<CR>:%!docker run --entrypoint="" -v /home/leo/workspace:/home/dev/ -w $(pwd \| sed -e 's/leo\/workspace/dev/g') --rm --name pulsar-format registry.pulsar.hionos.com/pulsar-dev-tools /bin/bash -c "make FORMAT_SRC='--pipe %' format"<CR>:1,3d<cr>:'a+3<CR>

" Markdown preview support
noremap <silent> <F4> :call OpenMarkdownPreview()<CR>

function! OpenMarkdownPreview() abort
  if exists('s:markdown_job_id') && s:markdown_job_id > 0
    call jobstop(s:markdown_job_id)
    unlet s:markdown_job_id
  endif
  let available_port = system(
    \ "lsof -s tcp:listen -i :40500-40800 | awk -F ' *|:' '{ print $10 }' | sort -n | tail -n1"
    \ ) + 1
  if available_port == 1 | let available_port = 40500 | endif
  let s:markdown_job_id = jobstart('grip ' . shellescape(expand('%:p')) . ' :' . available_port)
  if s:markdown_job_id <= 0 | return | endif
  call system('firefox http://localhost:' . available_port)
endfunction

" You should not use arrows to move
"map <Up> <Nop>
"map <Down> <Nop>
"map <Right> <Nop>
"map <Left> <Nop>

""""""""""""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""""""""""""
"let python_highlight_all=1
"augroup indents
"  autocmd FileType python set tabstop=4
"    autocmd FileType python set shiftwidth=4
"    augroup END

""""""""""""""""""""""""""""""""""""""""
" => Source configuration files on save
""""""""""""""""""""""""""""""""""""""""
"augroup configurationFiles
"  autocmd BufWritePost .vimrc source %
"  augroup END

""""""""""""""""""""""""""""""""""""""""
" => Configure vim-plug
" https://github.com/junegunn/vim-plug
"
" Basic usage:
" Download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" into ".vim/autoload" folder.
"
" Install with PlugInstall [name ...]
" Update or install with PlugUpdate [name ...]
""""""""""""""""""""""""""""""""""""""""
"call plug#begin('~/.vim/plugged')
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"
"Plug 'airblade/vim-gitgutter'
"
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"
"Plug 'valloric/youcompleteme'
"
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
"
"Plug 'vim-ruby/vim-ruby'
"
"Plug 'saltstack/salt-vim'
"
"Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"
"Plug 'fatih/vim-go'
"
"Plug 'vim-syntastic/syntastic'
"
"Plug 'posva/vim-vue'
"call plug#end()

""""""""""""""""""""""""""""""""""""""""
" => Configure FZF
" https://github.com/junegunn/fzf.vim
""""""""""""""""""""""""""""""""""""""""
"map <c-p> :Files<CR>
"map <c-m> :History<CR>

""""""""""""""""""""""""""""""""""""""""
" => Configure Airline
" https://github.com/vim-airline/vim-airline
""""""""""""""""""""""""""""""""""""""""
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'

""""""""""""""""""""""""""""""""""""""""
" => Configure vim-jsx
" https://github.com/mxw/vim-jsx
""""""""""""""""""""""""""""""""""""""""
"let g:jsx_ext_required = 0
"au BufNewFile,BufRead *.es6 set filetype=javascript
"au BufNewFile *.jsx 0r ~/.vim/jsx.template

""""""""""""""""""""""""""""""""""""""""
" => Configure NerdTree
" https://github.com/scrooloose/nerdtree
""""""""""""""""""""""""""""""""""""""""
"let NERDTreeMouseMode = 2
"map <leader>n :NERDTreeToggle<CR>
"let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

""""""""""""""""""""""""""""""""""""""""
" => Configure vim-go
" https://github.com/fatih/vim-go
""""""""""""""""""""""""""""""""""""""""
"au FileType go nmap <leader>r <Plug>(go-run)
"au FileType go nmap <leader>b <Plug>(go-build)
"au FileType go nmap <leader>t <Plug>(go-test)
"au FileType go nmap <leader>c <Plug>(go-coverage)
"
"au FileType go setlocal noexpandtab tabstop=4 shiftwidth=4

""""""""""""""""""""""""""""""""""""""""
" => Configure Syntastic
" https://github.com/vim-syntastic/syntastic
""""""""""""""""""""""""""""""""""""""""
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
"let g:syntastic_jsx_checkers = ['eslint']
"let g:syntastic_jsx_eslint_exec = 'eslint_d'
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exec = 'eslint_d'

" FIX FOR BUG IN NEOVIM
set guicursor=

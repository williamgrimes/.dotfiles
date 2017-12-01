"~/.vimrc

set nocompatible
set nu
set clipboard=unnamed
set hlsearch
set paste
set shortmess+=I
set tabstop=4

let mapleader = '\'

filetype off

autocmd FileType python map <buffer> <S-e> :w<CR>:!/usr/bin/env python %<CR>

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""
" POWERLINE
""""""""""""""""""""""""""""""""""""""""""""
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256
set laststatus=2


""""""""""""""""""""""""""""""""""""""""""""
" SPLIT NAVIGATIONS
""""""""""""""""""""""""""""""""""""""""""""
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""""""""
" FOLDING
""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent
set foldlevel=99
nnoremap <space> za 


execute pathogen#infect() 

""""""""""""""""""""""""""""""""""""""""""""
" START VUNDLE - ADD TO RTP
""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

Plugin 'vim-scripts/indentpython.vim'

highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |

au BufNewFile,BufRead *.js, *.html, *.css
     \ set tabstop=2 |
     \ set softtabstop=2 |
     \ set shiftwidth=2

Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

""python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-a>e :SyntasticCheck<CR> :SyntasticToggleMode<CR>

Plugin 'nvie/vim-flake8'

let python_highlight_all=1
syntax enable

Plugin 'scrooloose/nerdtree'

Plugin 'jistr/vim-nerdtree-tabs'

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

nmap <silent> <C-n> :NERDTreeToggle<CR>

Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-fugitive'

Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

let g:Powerline_symbols = 'fancy'

Plugin 'csv.vim'
hi CSVColumnEven term=bold ctermbg=6
hi CSVColumnHeaderEven term=bold ctermbg=6
hi CSVColumnOdd term=bold ctermbg=4
hi CSVColumnHeaderOdd term=bold ctermbg=4


Plugin 'epeli/slimux'
map <Leader>s :SlimuxREPLSendLine<CR>
"vmap <Leader>s :SlimuxREPLSendSelection<CR>
vnoremap <Leader>s :<C-w>SlimuxShellRun %cpaste<CR>:'<,'>SlimuxREPLSendSelection<CR>:SlimuxShellRun<CR>
map <Leader>b :SlimuxREPLSendBuffer<CR>
map <Leader>a :SlimuxShellLast<CR>
map <Leader>k :SlimuxSendKeysLast<CR>


call vundle#end()
""""""""""""""""""""""""""""""""""""""""""""
" END VUNDLE
""""""""""""""""""""""""""""""""""""""""""""

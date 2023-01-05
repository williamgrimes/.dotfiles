set hlsearch    " highlight all search results
set ignorecase  " do case insensitive search 
set incsearch   " show incremental search results as you type
set noswapfile  " disable swap file

" set number      " display line number
" :highlight LineNr ctermfg=DarkGrey

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab    " disable swap file
set noshiftround

" command W w !sudo tee % > /dev/null  " :W sudo saves the file
" https://jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
cmap w!! w !sudo tee % >/dev/null

" https://www.tdaly.co.uk/projects/vim-statusline-generator/
set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=%{StatuslineMode()}
set statusline+=\ 
set statusline+=%F
set statusline+=\ 
set statusline+=%{b:gitbranch}
set statusline+=%=
set statusline+=%y\ \[%{&ff}\]\ \[%{strlen(&fenc)?&fenc:'none'}\]
set statusline+=\ 
set statusline+=column:\[%c\]
set statusline+=\ 
set statusline+=line:\[%l/%L\]
set statusline+=\ 
set statusline+=%m

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction


function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  " autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
  autocmd BufEnter * let b:git_branch = StatuslineGitBranch()
augroup END

" vimdiff https://www.codyhiar.com/blog/vimdiff-better-highlighting/
highlight DiffAdd    cterm=BOLD ctermfg=0 ctermbg=2
highlight DiffDelete cterm=BOLD ctermfg=0 ctermbg=1
highlight DiffChange cterm=BOLD ctermfg=0 ctermbg=6
highlight DiffText   cterm=BOLD ctermfg=0 ctermbg=6


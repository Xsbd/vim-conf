" Author: Saurab Dhoubhadel
" -------------------------
" Heavily copied from Steve Losh's .vimrc and other internet sources
" ------------------------------------------------------------------

" echo ">^.^<"                " ascii cat on vim open
set nocompatible              " don't care about compatibility
syntax enable			            " syntax highlighting
filetype plugin indent on	    " enable filebrowsing plugin and indentation
set encoding=utf-8            " unicode support
set exrc                      " force to source local .vimrc if present
set secure                    " restrict usage of some commands in non-default .vimrc

" Key mappings
" ------------
" {{{

let mapleader=","             " <leader> is \ by default

" fix <ALT> mappings
for i in range(65,90) + range(97,122)				
  let c = nr2char(i)
  exec "map \e".c." <M-".c.">"
  exec "map! \e".c." <M-".c.">"
endfor

" careful with meta key bindings in tiling wm config
" map <ALT> + m for <ESC> for mode change
inoremap <M-m> <ESC>
" map <ALT> + b for <BS> in insert mode
inoremap <M-b> <BS>

" Shortcut to rapidly toogle `set list` to show/hide formatting
nmap <leader>l :set list!<CR>
" Change symbols for tabstops and EOL
set listchars=tab:▸\ ,eol:¬

" }}}

" Pathogen for managing packages
execute pathogen#infect()

" Installed Plugins
" -----------------
" {{{

" My Minimal Setup
" Solarized Color Scheme
" vim-airline Status Bar

" }}}


" Visual Candy
" ============
" {{{

" Solarized Color Scheme
" ----------------------
" {{{

colorscheme solarized
set background=dark
" toogle background transparency
let t:is_transparent = 0
function! Toggle_transparent()    " {{{
  if t:is_transparent==0
    hi Normal guibg=NONE ctermbg=NONE
    let t:is_transparent=1
  else
    set background=dark
    let t:is_transparent=0
  endif
endfunction   " }}}
com! TT call Toggle_transparent()

" }}}

" Spliting
" --------
" {{{

set splitbelow
set splitright
 
" split navigations
nnoremap <M-j> <C-W><C-J>
nnoremap <M-k> <C-W><C-K>
nnoremap <M-l> <C-W><C-L>
nnoremap <M-h> <C-W><C-H>

" }}}

" }}}

" Backups
" -----------------
" {{{

set history=50                        " Keep 50 lines of command line history
set nobackup                          " No *~ backup files
set nowritebackup                     " Do not make a backup before overwriting a file
set nowrapscan                        " Do not searche wrap around the end of the file
set noswapfile                        " Do not use a swapfile for the buffer

" }}}

" Wildmenu completion
" -------------------
" {{{

set wildmenu									" Display all matching files when we do tab completions
set wildmode=list:longest

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

set wildignore+=*.luac                           " Lua byte code

set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code

set wildignore+=*.orig                           " Merge resolution files

" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib

" }}}

" Fuzzy Search Files
" ------------------
" {{{

" Search down into subfolders (useful for fuzzy find using :find in dir)
set path+=**            " Provides tab-completion for all file-related tasks

" fuzzy find => :find *.rb
" find any file that's already open => :b a `->tab`

" }}}

" TAG JUMPING
" -----------
" {{{

" Create the 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R .
" jump to def: `->cntrl`+`]` or `g`+`->cntrl`+`]`
" jump back `->cntrl`+`t` to last jump

" autocomplete:
" use `->cntrl`+`n` and `->cntrl`+`p`
" ^x^n, ^x^f, ^x^]

" }}}

" FILE BROWSING
" -------------
" {{{

" Tweaks for browsing
let g:netrw_winsize= -28                         " absolute width of netrw window
let g:netrw_banner=0                             " disable annoying banner
let g:netrw_liststyle=3                          " tree view
let g:netrw_browse_split=4                       " open file in prior window
let g:netrw_altv=1                               " open splits to the right
" hide files
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

" use :Explore or :(X)explore to launch

" }}}

" SNIPPETS
" --------
" {{{

" Read an empty HTML template and move cursor to title
nnoremap <leader>html :-1read $HOME/.vim/templates/.skeleton.html<CR>3jwf>a
" Read an empty c template
nnoremap <leader>clang :-1read $HOME/.vim/templates/.skeleton.c<CR>3j
" Read an empty c++ template
nnoremap <leader>ccpp :-1read $HOME/.vim/templates/.skeleton.cpp<CR>3j

" }}}


" Custom Functions
" ================
" {{{

" Seth Brown's word processor
" ---------------------------
" {{{
" http://www.drbunsen.org/writing-in-vim/

func! WordProcessorMode()   " {{{
  map j gj
  map k gk
  setlocal spell spelllang=en_us
  set thesaurus+=~/.vim/thesaurus/mthesaur.txt
  set complete+=s
  setlocal wrap
  setlocal linebreak
  setlocal nolist
  setlocal textwidth=0
  setlocal wrapmargin=0
endfu   " }}}
com! WP call WordProcessorMode()

" }}}

" Steve Losh's code folding
" -------------------------
" {{{

set foldlevelstart=0
" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za
  
" "Refocus" folds
nnoremap ,z zMzvzz

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

function! MyFoldText() " {{{
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '

endfunction " }}}
set foldtext=MyFoldText()

" }}}

" }}}


" File-type specific
" ------------------
" {{{

" C
" {{{

augroup ft_c
    au!
    au FileType c setlocal foldmethod=marker foldmarker={,}
    au FileType c setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" }}}
" C++
" {{{

augroup ft_cpp
    au!
    au FileType cpp setlocal foldmethod=marker foldmarker={,}
    au FileType cpp setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" }}}
" Makefile
" {{{

augroup ft_make
    au!
    au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
augroup END

" }}}
" Markdowm
" {{{

augroup ft_markdown
    au!
    au BufNewFile,BufReadPre,BufRead,BufReadPost *.md setlocal filetype=markdown foldlevel=1
augroup END

" }}}
" Python
" {{{

augroup ft_Python
    au!
    au FileType py setlocal foldmethod=indent
    " set PEP8
    au BufNewFile,BufRead *.py setlocal ts=4 sts=4 sw=4 tw=79 ff=unix expandtab autoindent
augroup END

" }}}

" }}}

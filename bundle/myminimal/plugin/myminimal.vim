" Not Minimal, Minimal
" Author: Saurab Dhoubhadel

if exists('g:loaded_myminimal') || &compatible
  finish
else
  let g:loaded_myminimal = 'yes'
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

"------------------------------------------------------------------------------

" UI Layout
" ---------
set number                 "nu:    show line numbers
set numberwidth=4          "nuw:   width of line number column
set showmode               "smd:   shows current vi mode in lower left
set cmdheight=1            "ch:    make a little more room for error messages
set scrolloff=4            "so:    places a couple lines between the current line and the screen edge
set sidescrolloff=2        "siso:  places a couple lines between the current column and the screen edge
set laststatus=2           "ls:    makes the status bar always visible
set ttyfast                "tf:    improves redrawing for newer computers
set lazyredraw             "lz:    will not redraw the screen while running macros (goes faster)

"------------------------------------------------------------------------------

" Spaces and tabs
" ---------------
set autoindent                   " autoindent code
set backspace=indent,eol,start   " backspace to behave normally
set complete-=i                  " autocomplete suggestions
set tabstop=2                    "ts:    number of spaces that a tab renders as
set shiftwidth=2                 "sw:    number of spaces to use for autoindent
set softtabstop=2                "sts:   number of spaces that tabs insert
set expandtab                    "et:    uses spaces instead of tab characters
set smarttab                     "sta:   backspacing of expandtab

"------------------------------------------------------------------------------

" Search
" ------
set incsearch                   "is:    automatically begins searching as you type
set ignorecase                  "ic:    ignores case when pattern matching
set smartcase                   "scs:   ignores ignorecase when pattern contains uppercase characters
set hlsearch                    "hls:   highlights search results; ctrl-n or :noh to unhighlight
set gdefault                    "gd:    Substitute all matches in a line by default

"------------------------------------------------------------------------------

" Folding
" -------
set foldmethod=marker           "fdm:   fold by the indentation by default
set foldenable                  "fen:   fold by default
" space to fold and unfold
noremap <space> za

if has('linebreak')
  try
    set breakindent             "bri:   visually indent wrapped lines
    let &showbreak='↳'
  catch /E518:/
    " Unknown option: breakindent
  endtry
endif

"------------------------------------------------------------------------------

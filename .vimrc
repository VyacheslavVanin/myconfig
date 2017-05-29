set nocompatible
set vb t_vb= 
set novisualbell

set tabstop=4
set shiftwidth=4
set et

set hls
set incsearch
set ic
set smartcase

set rnu
set colorcolumn=80

set ai
set cindent
set smarttab
set smartindent
set nowrap
set ruler
syntax on
set backspace=indent,eol,start
set mouse=a

set scrolloff=10

if has("gui_running")
set guifont=DejaVu\ Sans\ Mono\ 20
set go=-M
endif

set background=dark
set laststatus=2
set cursorline
"set foldmethod=syntax
"set foldlevelstart=0
"let xml_syntax_folding=1

filetype off
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
Plug 'flazz/vim-colorschemes'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/The-NERD-tree'
Plug 'vim-scripts/surround.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'kris2k/a.vim'
call plug#end()

let g:plug_shallow = 0

let g:rainbow_active=0

let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_completeon=1
let g:ycm_autoclose_preview_window_after_insertion=1

let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_compactDoc = "yes"

let g:NERDTreeWinPos="right"

" ctrlp filter
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.tar.gz,*.o,*.png,*.jpg
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


filetype plugin indent on
try
    colo solarized
catch
endtry

let mapleader=' '

nnoremap <M-f> yiw :vimgrep /<C-R>"/ **/*.h **/*.c **/*.cpp **/*.hpp<CR> :copen<CR>
nnoremap <M-e><M-w> : e ++enc=cp1251<CR>
nnoremap <M-e><M-u> : e ++enc=utf-8<CR>

nnoremap <F12> : YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :  YcmForceCompileAndDiagnostics<CR><CR>

" DoxygenToolKit mappings
imap /** <Esc> :Dox<CR>
nnoremap <M-d> :Dox<CR>

" Switch source/header
nnoremap <F4> :A<CR>
nnoremap <M-o> : NERDTreeToggle <CR>
nnoremap <C-w>t :tabnew<CR>

" Toggle rainbow colors
nnoremap <F6> :SemanticHighlightToggle<CR>:RainbowToggle<CR>


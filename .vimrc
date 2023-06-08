set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set mouse=a                     "Allow use mouse to move vim cursor
set hidden                      "Open a new buffer without save current
set laststatus=2
set confirm
set splitright
set splitbelow

syntax on                       "Highlight syntax
let mapleader=','               "Use ',' as <leader>

" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

" Highlight line
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

" python 2 and 3 server
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/home/willian/.asdf/shims/python'

" True colors
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if (has('termguicolors'))
  set termguicolors
endif

" Toogle  line mode
augroup numbertoggle
autocmd!
autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

autocmd Filetype javascript setlocal ts=2 sw=2
autocmd Filetype vue setlocal ts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sw=2
autocmd Filetype blade setlocal ts=2 sw=2

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Security ==============================

set modelines=0
set nomodeline

" ================ Plugins  ========================

call plug#begin('~/.vim/plugged')

Plug 'kamailio/vim-kamailio-syntax'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'vim-vdebug/vdebug'
Plug 'terroo/vim-auto-markdown'
Plug 'APZelos/blamer.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kylelaker/riscv.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'scrooloose/nerdcommenter' "commenter <++>
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'pappasam/papercolor-theme-slim'
Plug 'dracula/vim', { 'as': 'dracula' }

"Plug 'jwalton512/vim-blade'
"Plug 'itchyny/lightline.vim'
"Plug 'craigemery/vim-autotag'
"Plug 'kebook-programacao-2/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
"Plug 'jvanja/vim-bootstrap3-snippets'
"Plug 'jiangmiao/auto-pairs'

call plug#end()

" ================ Plugins configuration  ========================

" Auto switch theme based on gnome color scheme
let gnome_theme = system('gsettings get org.gnome.desktop.interface color-scheme')

if stridx(gnome_theme, 'default') != -1
    set background=light
    colorscheme PaperColorSlim
else
    "'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
    let g:material_theme_style = 'darker'
    let g:material_terminal_italics = 1
    colorscheme material
end

let g:blamer_enabled = 1 " enable git blame

" Fuzzy configuration
let g:fzf_preview_window = []

let $FZF_DEFAULT_OPTS="--preview-window 'right:60%' --layout reverse --margin=0,0 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

let g:fzf_layout =
\ { 'window':
\ { 'width': 0.98, 'height': 0.7, 'yoffset': 0.94, 'border': 'rounded' }
\ }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Xdebug
let g:vdebug_options= {
\    "port" : 9003,
\    "ide_key" : 'PHPSTORM',
\}

" Coc extensions
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-pairs',
  \ 'coc-eslint',
  \ 'coc-json',
  \ '@yaegassy/coc-intelephense',
  \ 'coc-clangd',
  \ 'coc-php-cs-fixer',
  \ 'coc-tsserver',
  \ 'coc-sql',
  \ 'coc-java',
  \ 'coc-calc',
  \ 'coc-elixir',
  \ 'coc-pyright',
  "\ 'coc-ltex',
  "\ 'coc-reason',
  "\ 'coc-spell-checker',
  \ ]

" ================ Functions ===============

" Show COC doc
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ================ Keybindind and shortcuts ===============

if $XDG_SESSION_TYPE == 'x11'
    " Copy to clipboard x11
    vmap x "+c
    vmap <C-c> "+y
    vmap <C-x> "+c
    vmap <C-v> c<ESC>"+p
    imap <C-v> <ESC>"+pa
else
    " Copy to clipboard wayland
    nnoremap <C-@> :call system("wl-copy", @")<cr>
    xnoremap "+y y:call system("wl-copy", @")<cr>
    nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
    nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p
    "xnoremap <silent> <C-x> y:call system("wl-copy", @") y:'<,'>d<cr>
    xnoremap <silent> <C-c> y:call system("wl-copy", @")<cr>
    nnoremap <silent> <C-v> :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
endif

map <C-r> :source ~/.vimrc<cr>

map <C-s> :w<cr>
map <C-z> :u<cr>
map <C-q> :q<cr>

" Move line Up or Down
xnoremap <S-A-k>   :<C-u>silent! '<,'>move-2<CR>gv=gv
nnoremap <S-A-k>   :<C-u>silent! move-2<CR>==
nnoremap <S-A-j> :<C-u>silent! move+<CR>==
xnoremap <S-A-j> :<C-u>silent! '<,'>move'>+<CR>gv=gv

nnoremap <C-b> :NERDTreeToggle<cr>
nnoremap <c-p> :Files<cr>
nnoremap <s-m-p> :GFiles<cr>
nnoremap <silent> <S-Tab> :call <SID>show_documentation()<cr>
nnoremap <silent> <Esc><Esc> :noh<cr> :call clearmatches()<cr>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> <C-LeftMouse> <Plug>(coc-definition)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap ++ <plug>NERDCommenterToggle
vmap ++ <plug>NERDCommenterToggle

nnoremap <leader>tt :tabnew<cr>
nnoremap <leader>tn :tabnext<cr>
nnoremap <leader>tp :tabprevious<cr>

map tt :tabnew<cr>
map tn :tabnext<cr>
map tp :tabprevious<cr>

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

command! -nargs=1 GitFind !git grep -n '<args>'

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
"Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
"Use K to show documentation in preview window
nnoremap <silent> K :call  <SID>show_documentation()<cr>
"Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<cr>
"Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<cr>
"Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<cr>
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" ================ Extra ===============

" CocConfig:
"{
"    "languageserver": {
"        "ocaml-lsp": {
"            "command": "opam",
"            "args": ["config", "exec", "--", "ocamllsp"],
"            "filetypes": ["ocaml", "reason"]
"        }
"    },
"    "diagnostic.virtualText": true,
"    "diagnostic.virtualTextCurrentLineOnly": false
"}

lua << EOF
require('telescope').setup{
  file_ignore_patterns = { "^./.git/", "^node_modules/", "^vendor/" }
}
EOF

"vimrc file maintained by Damian Michalski for personal use
"Based on vimrc from Marek Tkaczyk

" NOTE: you need to create 'backup', 'swap', 'undo' and undodir folders inside ~/.vim
" NOTE: in order for airline to look good, you need to install and select powerline fonts pack
" NOTE: markonm/traces.vim is incompatible with neovim - to make it work, turn off inccommand
" NOTE: in order to make language client work, you need to execute:
"      yarn global add javascript-typescript-langserver
" That will install javascript-typescript-stdio

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Plugins area                        "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Increase the plug timeout for YCM to install faster
let g:plug_timeout = 180

" Function to build YCM only if necessary (it's quite heavy, you know)
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --js-completer
  endif
endfunction

call plug#begin('~/.config/nvim/plugged')

""""""" Vim appearance """""""

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'

""""""""""""""""""""""""""""""""""""""

""""""" Search """""""
" File fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" AMAZING plugin for searching text inside project
Plug 'mhinz/vim-grepper'

""""""""""""""""""""""

""""""" Syntax highlighters/indents """""""

Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
" Language pack for many languages
Plug 'sheerun/vim-polyglot'

"""""""""""""""""""""""""""""""""""""""""""

""""""" Utility """""""

" Project tree explorer
Plug 'scrooloose/nerdtree'
" Easy commenting plugin, press gc to comment a line in visual mode or gcc in normal mode
Plug 'tpope/vim-commentary'
" autoclosing brackets
Plug 'Raimondi/delimitMate'
" autoclosing html tags
Plug 'alvan/vim-closetag'
" automatically hightlight html tags closing
Plug 'Valloric/MatchTagAlways'
" changing surroundings of the selection, cs"' changes " to ', ds" deletes ", cst" adds "
Plug 'tpope/vim-surround'
" autocompletion for javascript
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" To make tsuguyomi work
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Async intellisense for typescript (as well as error highlighting
Plug 'Quramy/tsuquyomi'
" Async linter
Plug 'w0rp/ale'
" Dispatching actions
Plug 'tpope/vim-dispatch'
" Changing root to project dir on every file open
Plug 'airblade/vim-rooter'
" Tmuxline
"Plug 'edkolev/tmuxline.vim'
" Git integration for vim (installed to see branch name on vim-airline), useful for :GitBlame
Plug 'tpope/vim-fugitive'
" For testing integration
Plug 'janko-m/vim-test'
" For integrating tmux with vim (for janko-m/vim-test)
"Plug 'benmills/vimux'
" An amazing plugin for live preview when executing substitute command
Plug 'markonm/traces.vim'
" Highlights new/mofified/deleted lines in the "gutter"
Plug 'mhinz/vim-signify'
" If you prefer Ctrl+h/j/k/l for navigating across vim/tmux splits,
" this plugin will integrate Vim and Tmux, so that you can seamlessly
" Jump across the border of a vim/tmux split
"Plug 'christoomey/vim-tmux-navigator'

"""""""""""""""""""""""

"""""""""""""""""""""""
" Monokai colorscheme
Plug 'crusoexia/vim-monokai'
Plug 'altercation/vim-colors-solarized'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Settings area                       "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype indent plugin on
syntax on
 
"solarized color scheme
syntax enable

" To make colors work, note that you need to change ^[ to actual esc, so do
" <C-v><ESC>
" set t_8f=;2;%lu;%lu;%lum
" set t_8b=;2;%lu;%lu;%lum

"set termguicolors "to enable true colors
set background=dark
colorscheme solarized
"set t_Co=256     "needed to work in ubuntu terminal

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\tmp\*,*.swp,*.zip,*.exe  " Windows

set completeopt-=preview

"Must have options, highly recommended by community
set hidden
set wildmenu

set showcmd

set hlsearch
set incsearch

set nocursorcolumn

"Smart options, good for programming
set ignorecase
set smartcase

set backspace=indent,eol,start
set smarttab autoindent

set ruler

set laststatus=2
set confirm

set cmdheight=2
set shortmess=a
"show line numbers
set number

" fzf
set rtp+=~/.config/nvim/.fzf/bin/fzf

" yank to clipboard
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

"for webpack to catch all writes
set backupcopy=yes

" disable auto break long lines
set textwidth=0
set nowrap

"Indentation options
set expandtab
set shiftwidth=4
set softtabstop=4
"Vim will store undo externally, so after closing and reopening file you can undo changes
set undofile

"Setting .swp files to be centralized, not clutter the edit folder
set backupdir=~/.config/nvim/backup//
set directory=~/.config/nvim/swap//
set undodir=~/.config/nvim/undo//

set pastetoggle=<F5>

""Display a faint line at 150 chars
"set colorcolumn=150

" More natural splits
set splitbelow
set splitright


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Plugins settings area               "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""" arcticicestudio/nord-vim """""""
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_cursor_line_number_background = 1



""""""" vim-airline/vim-airline """""""
let g:airline_powerline_fonts = 1
let g:airline_theme = "nord"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

""""""" Valloric/YouCompleteMe """""""
set encoding=utf-8
let g:ycm_extra_conf_globlist = ['~/*']
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
let g:ycm_server_keep_logfiles = 1

""""""" pangloss/vim-javascript """""""
let g:javascript_plugin_jsdoc = 1

""""""" othree/javascript-libraries-syntax.vim """""""
let g:used_javascript_libs = 'underscore,jquery,react'

""""""" ternjs/tern_for_vim """""""
" enable keyboard shortcuts
let g:tern_map_keys=1
" show argument hints
let g:tern_show_argument_hints='on_hold'

""""""" junegunn/fzf """""""


""""""" scrooloose/nerdtree """""""
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.DS_Store$']

""""""" alvan/vim-closetag """""""
let g:closetag_filenames = '*.html,*.jsx,*.js'

""""""" Valloric/MatchTagAlways """""""
let g:mta_filetypes = {
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'xml' : 1,
  \ 'javascript.jsx' : 1,
\}

""""""" Raimondi/delimitMate """""""
let delimitMate_matchpairs = "(:),[:],{:}"

""""""" w0rp/ale """""""
let g:ale_lint_on_text_changed = 'never'

""""""" Quramy/tsuquyomi """""""
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_disable_quickfix = 1

""""""" mhinz/vim-grepper """""""
let g:grepper = {}
let g:grepper.ag = {}
" let g:grepper.ag.grepprg = 'ag --vimgrep  'FindProjectRoot('.git')

""""""" mxw/vim-jsx """""""
let g:jsx_ext_required = 0

""""""" edkolev/tmuxline """""""

" For tmuxline + vim-airline integration
let g:airline#extensions#tmuxline#enabled = 1
" Start tmuxline even without vim running
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
" To make it nice
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'c'    : '#H',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '%a',
      \'y'    : '#W %R',
      \'z'    : '#H'}


""""""" janko-m/vim-test """""""
let test#strategy = "vimux"
let g:test#javascript#jest#file_pattern = '.*\.spec\.js'


""""""" mhinz/vim-signify """""""
let g:signify_vcs_list = [ 'git' ]

""""""" altercation/vim-colors-solarized """""""
let g:solarized_termcolors=256

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Remaps area                         "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I said write it!
cmap w!! w !sudo tee > /dev/null %

" Used for mhinz/vim-grepper
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" remap ctrl+p to :FZF
map <C-p> :Files<cr>
nmap <C-p> :Files<cr>

nnoremap <leader>ev :split <cr>
nnoremap <leader>sv :source <cr>
noremap <silent> <C-h> <c-w>h
noremap <silent> <C-l> <c-W>l
noremap <silent> <C-k> <c-w>k
noremap <silent> <C-j> <c-w>j

cnoremap tabnew :tabnew<cr>:Vexplore<cr>
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>

" This is a quick way to call search-and-replace on a current word
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" To make  n to always search forward and N backward
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

if executable('javascript-typescript-stdio')
  " <leader>ld to go to definition
  autocmd FileType javascript nnoremap <buffer>
    \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
  " <leader>lh for type info under cursor
  autocmd FileType javascript nnoremap <buffer>
    \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
  " <leader>lr to rename variable under cursor
  autocmd FileType javascript nnoremap <buffer>
    \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Groups area                         "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"augroup general
"    autocmd!
"    " autocmd VimEnter * :Vexplore
"    autocmd vimenter * NERDTree
"    " autocmd FileType netrw setl bufhidden=delete
"augroup END

augroup js_files
    autocmd!
    autocmd FileType javascript let maplocalleader = ";"
    autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType javascript setlocal commentstring=//%s
augroup END

"Suffixes for 'gf' command to associate filetypes with extensions (for files jumping)
augroup suffixes
    autocmd!
    let associations = [
        \["javascript", ".js,.jsx"],
        \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

call SourceIfExists('~/.additions/vimrc')


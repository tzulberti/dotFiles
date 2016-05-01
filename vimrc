" no vi-compatible
set nocompatible

" Setting up Vundle - the vim plugin bundler
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" required for vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Better file browser
Bundle 'scrooloose/nerdtree'
" Code commenter
Bundle 'scrooloose/nerdcommenter'
" Class/module browser
Bundle 'majutsushi/tagbar'
" Git integration
Bundle 'motemen/git-vim'
" Powerline
"Bundle 'Lokaltog/vim-powerline'
" Git diff icons on the side of the file lines
Bundle 'airblade/vim-gitgutter'
" Python code checker
Bundle 'pyflakes.vim'
" Gvim colorscheme
Bundle 'Wombat'
" Vim vividchalk color scheme
Bundle "tpope/vim-vividchalk"
" PyFlakes integration
" Bundle "nvie/vim-flake8"
Bundle 'rust-lang/rust.vim'

" Colores en los archivos de css
Bundle 'https://github.com/gorodinskiy/vim-coloresque.git'
" Configuracion de Go
Bundle 'https://github.com/jnwhiteh/vim-golang.git'

" Como el Powerline pero sin necesitar de python
Bundle 'https://github.com/itchyny/lightline.vim.git'

" Para las cosas de git
Bundle 'https://github.com/tpope/vim-fugitive.git'

" Cada vez que se agrega un nuevo bundle se tiene que correr
" el siguiente comando: vim +BundleClean +BundleInstall! +qa

" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" allow plugins by file type
filetype plugin on
filetype indent on

" ---------------------------------------------------------------
"  Configuracion de los colores.
"
"  Es necesario el &t_Co = 256 para que el powerline funcione con
"  colores correctamente
let &t_Co = 256
colorscheme vividchalk
syntax on

" ----------------------------------------------------------------
" Configuration data for powerline
"
set laststatus=2 " Always display the statusline in all windows

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"RO":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"(Changed)":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ">>", 'right': "<<" },
      \ 'subseparator': { 'left': "|", 'right': "|" }
      \ }

" -----------------------------------------------------------------
"  Cosas misceleanas de vim
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
" Para que no cree los archivos de backup y no joda la vida
set nobackup
set noswapfile



" ---------------------------------------------------------
" Cosas relacionadas al formato del archivo
set encoding=utf-8
set ff=unix " set the file format to the unix one (end of lines)


" ---------------------------------------------------------
" Cosas relacionadas al tema de tabs y espacios
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'

filetype plugin indent on

set tabstop=4     " a tab is four spaces
set expandtab     " when tab is pressed, the tab is replaced by the <tabstop>
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set nowrap

" Para que en los makefiles los tabs sigan existiendo.
autocmd FileType make setlocal noexpandtab

" borra los espacios extras al final de las lineas
" (guarda antes la posición y la restablece luego)
autocmd BufWritePre *.py mark z | %s/ *$//e | 'z
autocmd BufWritePre *.js mark z | %s/ *$//e | 'z
autocmd BufWritePre *.sql mark z | %s/ *$//e | 'z
autocmd BufWritePre .vimrc mark z | %s/ *$//e | 'z

" -------------------------------------------------------------------
"  Cosas relacionadas a la busqueda
"
set hlsearch      " highlight search terms
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set incsearch     " show search matches as you type


" ----------------------------------------------------------------
" Cosas relacionadas a cuando se trabaja con tabs
"
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
imap <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>



" --------------------------------------------------------------
" Configuracion para el plugin de pyflakes
"
" Cuando se guada un documeto de python, chequea temas de pepe8
" del mismo
"let g:flake8_builtins="_,apply"
"autocmd FileType python map <buffer> <F3> :call Flake8()<CR>

" ---------------------------------------------------------------
" Funcionalidades varias

" Por default muestra el numero de linea, pero eso se puede ocultar
" con F2
set number
map <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Abre u oculta el navegador de archivos
imap <F3> <esc>:NERDTreeToggle<CR>
map <F3> <esc>:NERDTreeToggle<CR>

" Ignore files on NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Muestra toda la informacion del modulo que se esta usando
let g:tagbar_usearrows = 1
imap <F4> <esc>:TagbarToggle<CR><C-w><C-w>
map <F4> <esc>:TagbarToggle<CR><C-w><C-w>

" Entro o salgo del modo paste con F5
imap <F5> <esc>:set paste!<CR>:set ruler<CR>
map <F5> :set paste!<CR>:set ruler<CR>

" Para poder grabar usando sudo
" En caso de que sea necesario una password la va a pedir
" De todas formas pregunta para recargar el archivo, pero
" no encontre una solucion mejor
imap <F7> <esc>:w !sudo tee > /dev/null %
map <F7> :w !sudo tee > /dev/null %
ca w!! w !sudo tee "%"


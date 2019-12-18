if has('win32') || has('win64')
  let g:plugged_home = '~/AppData/Local/nvim/plugged'
else
  let g:plugged_home = '~/.vim/plugged'
endif


" Plugins List
call plug#begin(g:plugged_home)
    " Para las cosas de git
    Plug 'tpope/vim-fugitive'

    " Vim vividchalk color scheme
    Plug 'tpope/vim-vividchalk'

    " Better file browser
    Plug 'scrooloose/nerdtree'

    " Class/module browser
    Plug 'majutsushi/tagbar'

    " Git diff icons on the side of the file lines
    Plug 'airblade/vim-gitgutter'

    " Power line (sin tantas dependencias)
    Plug 'vim-airline/vim-airline' 

    " Muestra la linea de identiacion
    Plug 'Yggdroot/indentLine'

    " Python code checker
    Plug 'w0rp/ale'

    " Grammarous checker for vim
    Plug 'rhysd/vim-grammarous'


call plug#end()


" ---------------------------------------------------------------
"  Configuracion de los colores.
"
"  Es necesario el &t_Co = 256 para que el powerline funcione con
"  colores correctamente
let &t_Co = 256
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

colorscheme vividchalk
syntax on

" ----------------------------------------------------------------
" Configuration data for powerline
"

" -----------------------------------------------------------------
"  Cosas misceleanas de vim
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set titleold=""
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
autocmd BufWritePre *.rst mark z | %s/ *$//e | 'z
autocmd BufWritePre *.md mark z | %s/ *$//e | 'z
"autocmd BufWritePre *.js mark z | %s/ *$//e | 'z
"autocmd BufWritePre *.sql mark z | %s/ *$//e | 'z
"autocmd BufWritePre .vimrc mark z | %s/ *$//e | 'z
"autocmd BufWritePre .json mark z | %s/ *$//e | 'z
autocmd BufWritePre .yaml mark z | %s/ *$//e | 'z
autocmd BufWritePre .yml mark z | %s/ *$//e | 'z
autocmd BufWritePre .sh mark z | %s/ *$//e | 'z

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
map <F2> :set nonumber!<CR>:set foldcolumn=0<CR><CR>:IndentLinesToggle<CR><CR>:GitGutterToggle<CR>

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

" Para que al buscar por nombre no eliga el primero que aparece
" sino que se comporte como bash
set wildmode=longest,list,full
set wildmenu

" ------------------------------------------------------------
"  Configuracion de varios plugins

" No mostrar en ciertos tipos de buffers y archivos
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" Para que no ocule los " en los json y los * en los archivos de markup
" y ese estilo de cosas
let g:indentLine_setConceal = 0


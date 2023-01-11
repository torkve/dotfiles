set nocompatible

" Определяем, vim или neovim {{{
if fnamemodify(expand("$MYVIMRC"), ":t") == ".vimrc"
    let $VIMHOME = fnamemodify(expand("~/.vim"), ":p")
else
    let $VIMHOME = fnamemodify(expand("$MYVIMRC"), ":p:h")
endif
" }}}

" Настройки для включения/выключения хоткеев {{{
" они должны обязательно быть в самом начале до плагинов, иначе не работают
let g:errormarker_disablemappings = 1
let g:neocomplete#enable_cursor_hold_i = 1 " при движении стрелочками убирать дополнения нафиг
" }}}

" NeoBundle {{{
" Включаем NeoBundle
if has('vim_starting')
    set rtp+=$VIMHOME/bundle/neobundle.vim/
endif
call neobundle#begin(expand($VIMHOME.'/bundle/'))

" Собственно сам NeoBundle
NeoBundle 'Shougo/neobundle.vim'
" Vimproc для асинхронного запуска команда (NeoBundle, Unite)
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" Unite — кольцо to rule 'em all
NeoBundle 'Shougo/unite.vim'
" и его запчасти
NeoBundleLazy 'Shougo/unite-outline'
NeoBundleLazy 'tsukkee/unite-help'
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundleLazy 'ujihisa/unite-locate'
NeoBundleLazy 'thinca/vim-unite-history'
NeoBundleLazy 'osyo-manga/unite-filetype'
NeoBundleLazy 'osyo-manga/unite-quickfix'
NeoBundleLazy 'osyo-manga/unite-fold'
NeoBundleLazy 'tacroe/unite-mark'

" Статусная строка
NeoBundle 'joedicastro/vim-powerline', 'develop'
NeoBundle 'zhaocai/linepower.vim'

" Открытие по файл:строка:колонка
NeoBundle 'kopischke/vim-fetch'

" Различные Web-API
NeoBundle 'mattn/webapi-vim'

" HEX-редактор
NeoBundleLazy 'vim-scripts/hexman.vim', {'autoload': {'mappings': [['ni', '<Plug>HexManager']]}}

" Автодополнение (, [, {, ', ", ...
NeoBundle 'kana/vim-smartinput'
NeoBundle 'Shougo/neocomplete.vim', {'vim_version': '7.3.885'}

" закомментирование кода
NeoBundleLazy 'tpope/vim-commentary', {'autoload': {'filetypes': ['python', 'ocaml', 'cpp']}}

" проверка синтаксиса
NeoBundle "w0rp/ale"

" Сниппеты
" NeoBundle 'SirVer/ultisnips'
" NeoBundle 'honza/vim-snippets'
" NeoBundle 'bartolomiejdanek/better-snipmate-snippets'

" Просмотр доков в табах
NeoBundle 'powerman/vim-plugin-viewdoc'

" Go
NeoBundleLazy 'jnwhiteh/vim-golang', {'autoload': {'filetypes': ['go']}}

" python
NeoBundleLazy 'klen/python-mode', 'develop', {'autoload': {'filetypes': ['python']}}
" NeoBundleLazy 'jmcantrell/vim-virtualenv', {'autoload': {'filetypes': ['python']}}
NeoBundleLazy 'Yggdroot/indentLine', {'autoload': {'filetypes': ['python']}}
" NeoBundleLazy 'alfredodeza/coveragepy.vim', {'autoload': {'filetypes': ['python']}}
" NeoBundleLazy 'davidhalter/jedi-vim', {'autoload': {'filetypes': ['python']}}
NeoBundleLazy 'vim-voom/VOoM', {'autoload': {'filetypes': ['python']}}

" C++
NeoBundleLazy 'Mizuchi/STL-Syntax', {'autoload': {'filetypes': ['cpp']}}
NeoBundleLazy 'Valloric/YouCompleteMe', {
            \ 'install_process_timeout': 900,
            \ 'build' : {
                \ 'mac'     : './install.py --clang-completer --rust-completer',
                \ 'unix'    : './install.py --clang-completer --rust-completer',
                \ 'windows' : 'install.py',
                \ 'cygwin'  : './install.py'
            \ },
            \ 'autoload': {'filetypes': ['c', 'cpp', 'rust']}}

" QML
NeoBundleLazy 'peterhoeg/vim-qml', {'autoload': {'filetypes': ['qml']}}

" HTML/CSS
NeoBundleLazy 'Rykka/colorv.vim', {'autoload' : {
            \ 'commands' : [
                             \ 'ColorV', 'ColorVView', 'ColorVPreview',
                             \ 'ColorVPicker', 'ColorVEdit', 'ColorVEditAll',
                             \ 'ColorVInsert', 'ColorVList', 'ColorVName',
                             \ 'ColorVScheme', 'ColorVSchemeFav',
                             \ 'ColorVSchemeNew', 'ColorVTurn2'],
            \ }}
NeoBundleLazy 'othree/html5.vim', {'autoload': {'filetypes': ['html', 'xhtml', 'css']}}
NeoBundleLazy 'mattn/emmet-vim', {'autoload': {'filetypes': ['html', 'xhtml', 'css', 'xml', 'xls', 'markdown', 'mkd']}}

" js
" NeoBundleLazy 'pangloss/vim-javascript', {'autoload': {'filetypes': ['js', 'javascript']}}
NeoBundleLazy 'maksimr/vim-jsbeautify', {'autoload': {'filetypes': ['js', 'javascript']}}

" NeoBundle 'majutsushi/tagbar'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'mhinz/vim-startify'

" Файловый менеджер
NeoBundleLazy 'Shougo/vimfiler', {'autoload' : { 'commands' : ['VimFiler']}}

" reveals all the character info, Unicode included
NeoBundle 'tpope/vim-characterize'
" text-objects
"NeoBundle 'kana/vim-textobj-entire' " ae, ie
"NeoBundle 'kana/vim-textobj-indent' " ai, ii, aI, iI
"NeoBundle 'kana/vim-textobj-lastpat' " a/, i/, a?, i?
"NeoBundle 'kana/vim-textobj-line' " al, il
"NeoBundle 'kana/vim-textobj-underscore' " a_, i_
"NeoBundle 'kana/vim-textobj-user'

" VCS
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'torkve/vim-vcscommand'

" Diff / patch
NeoBundle 'junkblocker/patchreview-vim'

" markdown
NeoBundleLazy 'plasticboy/vim-markdown', {'autoload': {'filetypes': ['markdown', 'mkd']}}
NeoBundleLazy 'joedicastro/vim-markdown-extra-preview', {'autoload': {'filetypes': ['markdown', 'mkd']}}
" rst
NeoBundleLazy 'Rykka/riv.vim', {'autoload': {'filetypes': ['rst']}}
NeoBundleLazy "Rykka/InstantRst", {'autoload': {'filetypes': ['rst']}}

" json
NeoBundleLazy 'vim-scripts/JSON.vim', {'autoload': {'filetypes': ['json']}}
" po
NeoBundleLazy 'vim-scripts/po.vim--gray', {'autoload': {'filetypes': ['po']}}

" OCaml
" NeoBundleLazy 'torkve/merlin.git', {'depends': 'def-lkb/vimbufsync.git',
"     \ 'build': {
"     \   'unix': './configure --bindir ~/bin --without-vimbufsync && make install-binary'
"     \   },
"     \ 'autoload': {'filetypes': ['ocaml']},
"     \ 'rtp': 'vim/merlin'
"     \ }
NeoBundleLazy 'torkve/ocaml-conceal.vim', {'autoload': {'filetypes': ['ocaml']}}

" LSP
" NeoBundle 'prabirshrestha/async.vim'
" NeoBundle 'prabirshrestha/asyncomplete.vim'
" NeoBundle 'prabirshrestha/vim-lsp'
" NeoBundle 'prabirshrestha/asyncomplete-lsp.vim'

" Rust
" NOTE: use 'cargo install racer' and 'rustup component add rust-src'
NeoBundleLazy 'rust-lang/rust.vim', {'autoload': {'filetypes': 'rust', 'filename_patterns': '*.rs'}}
NeoBundleLazy 'racer-rust/vim-racer', {'autoload': {'filetypes': 'rust', 'filename_patterns': '*.rs'}, 'install_process_timeout': 900}

" NeoBundle 'tyru/current-func-info.vim'
" NeoBundle 'vim-scripts/bufexplorer.zip'
NeoBundle 'vim-scripts/errormarker.vim'

" project
NeoBundle 'dimonomid/vim-dfrank-util'
NeoBundle 'dimonomid/vim-indexer'
NeoBundle 'dimonomid/vim-vimprj'

NeoBundle 'doxygen-toolkit', {'type': 'nosync', 'base': $VIMHOME.'/bundle'}
NeoBundleLazy 'conque-gdb', {'type': 'nosync', 'base': $VIMHOME.'/bundle', 'autoload': {'filetypes': ['cpp']}}

" Цветовая схема
NeoBundle 'Lokaltog/vim-distinguished', 'develop'

" Jabber
" NeoBundle "ironcamel/vimchat", {
"     \ 'build': {
"     \   'unix': 'mkdir -p ~/.vimchat && cp icon*.gif ~/.vimchat/; [ -f ~/.vimchat/config ] && cp config ~/.vimchat/config.example || cp config ~/.vimchat/'
"     \   }
"     \ }

" REST-консоль
NeoBundleLazy "diepm/vim-rest-console", {'autoload': {'filetypes': ['rest']}}

" Scala
NeoBundleLazy 'derekwyatt/vim-scala', {'autoload': {'filetypes': ['scala']}}

" TOML
NeoBundleLazy 'maralla/vim-toml-enhance', {'depends': 'cespare/vim-toml', 'autoload': {'filetypes': ['toml']}}

NeoBundleCheck " Проверяем бандлы, при необходимости устанавливаем

call neobundle#end()
"}}}

" Общие настройки {{{
filetype plugin indent on " включить плагины и отступы
syntax on " включить подсветку синтаксиса

set noerrorbells visualbell t_vb= " Отключаем моргания экрана

set hlsearch " включить подсветку поиска
set smc=0 " отключить ограничение на максимальную позицию в строке при поиске

set ignorecase " игнорировать регистр
set smartcase " умный поиск

set tabstop=4 " число пробелов для таба
set softtabstop=4 " число пробелов для таба при редактировании
set shiftwidth=4 " число пробелов для отступа при форматировании
set expandtab " превращать табы в пробелы

scriptencoding utf-8
set termencoding=utf-8 " кодировка терминала
set fileencodings=utf8,cp1251 " возможные кодировки файлов и последовательность определения
set encoding=utf8 " кодировка вима
set title " Устанавливать заголовок окна
set autoindent " автоотступы включены
set smartindent " умные отступы
set laststatus=2 " показывать статус с именем файла только для нескольких открытых файлов
set shortmess=atToOI " Сокращение сообщений в статусе
set iskeyword+=_,$,@,%,# " Поиск ключевых слов
set ruler " показывать положение курсора
set ttyfast " быстрый терминал, плавный скроллинг
set showcmd " показывать вводимую команду
set history=50 " сохранять 50 строк истории команд
" '20   - Запоминать метки для последних 20 файлов
" \"50  - Сохранять 50 линий для каждого регистра
" :20   - Помнить 20 элементов в истории команд
" %     - Запоминать список буферов (если вим запущен без аргументов)
" n     - имя файла .viminfo
set viminfo='20,\"50,:20,%,n$VIMHOME/.viminfo

set fillchars=vert:\|,fold:-,diff:·
set listchars=tab:\ \  " Табы отображать пробелами
set showbreak= " Не отображать разрывы строк
set concealcursor="nvi" " Менять операторы на картинки во всех режимах
set balloonevalterm

set wildmenu " использовать меню для завершения команд
set wildmode=full " по первому табу показывать список и завершать самой длинной командой, по второму дополнять следующим вариантом и показывать меню
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.luac,*.pyc,*.jar,*.stats,*.class,*.mo,*.la,*.so,*.obj,*.sw?,*.bak,*.jpg,*.png,*.xpm,*.gif,*~  " игнорируемые файлы

set complete="" " Слова откуда будем завершать
set complete+=t " из тегов
set complete+=. " Из текущего буфера
set complete+=k " Из словаря

set completeopt+=menu " Выдавать менюшку с дополнениями
set completeopt+=menuone " Показывать менюшку, даже если дополнение всего одно
set completeopt+=longest " Автоматически дописывать совпадающий среди всех возможных дополнений кусок
set completeopt+=preview " Показывать дополнительную инфу о дополнениях

set spelllang=ru_yo,ru_ru,en_us " Проверка орфографии
set nospell " По умолчанию проверка выключена

" пусть \ будет кнопкой <Leader> в командах
let mapleader="\\"
" S-Ins вставляет из гуёвого буфера
map <S-Insert> <MiddleMouse>
" Пусть Y ведёт себя по аналогии с D и C
nnoremap Y y$
" не используем режим Ex. Пусть лучше Q используется для форматирования текста
nmap Q gq
" p в Визуальном режиме будет заменять выделенный текст регистром "".
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
" Использовать Ctrl+f для "умного" дополнения
imap <C-F> <C-X><C-O>
" Использовать Ctrl+c для копирования в глобальный буфер
vmap <C-C> "+yi
" Использовать Ctrl+v для вставки из глобального буфера
imap <C-V> <esc>"+gPi

" При ресайзе терминала выравниваем размеры окон
au VimResized * exe "normal! \<c-w>="
" Переместиться на место, где был курсор при прошлом редактировании файла
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

" syn region myFold start="{" end="}" transparent fold
syn sync fromstart
set foldmethod=syntax " тип фолдинга
set foldnestmax=2 " максимальная вложенность фолдинга
set fo+=cr
set pastetoggle=<F5>
set backspace=2  " В режиме вставки можно стирать всё

" Сохраняем от рута
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
" }}}

" Quickfix {{{
function! s:QuickfixToggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            lclose
            return
        endif
    endfor
    copen
endfunction
command! ToggleQuickfix call <SID>QuickfixToggle()

nnoremap <silent> <Leader>q :ToggleQuickfix<CR>
" }}}

" Цвета {{{
if &term =~ "xterm" || &term =~ "rxvt-256color" || &term =~ "rxvt-unicode" || &term =~ "screen-256color"
	let &t_Co = 256
	" Statusline highlighting {{{
    " let s:round_stl = 0

    " au ColorScheme * call <SID>StatusLineColors(s:statuscolors)
    " au BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 1)
    " au BufLeave,BufWinLeave,WinLeave,CmdwinLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 0)
    " au InsertEnter,CursorHoldI * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Insert', 1)
    " }}}
endif
set background=dark
"if &term =~ "xterm"
"  "256 color --
"  let &t_Co=256
"  " restore screen after quitting
"  "  set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
"  if has("terminfo")
"    let &t_Sf="\ESC[3%p1%dm"
"    let &t_Sb="\ESC[4%p1%dm"
"  else
"    let &t_Sf="\ESC[3%dm"
"    let &t_Sb="\ESC[4%dm"
"  endif
"endif

colo distinguished
" }}}

" ColorV {{{
let g:colorv_cache_file=$VIMHOME.'/.tmp/vim_colorv_cache'
let g:colorv_cache_fav=$VIMHOME.'/.tmp/vim_colorv_cache_fav'
" }}}

" Unite {{{

" files
nnoremap <silent><Leader>o :Unite -silent -start-insert file<CR>
nnoremap <silent><Leader>O :Unite -silent -start-insert file_rec/async<CR>
" nnoremap <silent><Leader>m :Unite -silent file_mru<CR>
" buffers
nnoremap <silent><Leader>b :Unite -silent buffer<CR>
" tabs
nnoremap <silent><Leader>B :Unite -silent tab<CR>
" buffer search
"nnoremap <silent><Leader>f :Unite -silent -no-split -start-insert -auto-preview
"            \ line<CR>
nnoremap <silent>[menu]8 :UniteWithCursorWord -silent -no-split -auto-preview
            \ line<CR>
" yankring
nnoremap <silent><Leader>i :Unite -silent history/yank<CR>
" grep
nnoremap <silent><Leader>a :Unite -silent -no-quit grep<CR>
" help
nnoremap <silent> g<C-h> :UniteWithCursorWord -silent help<CR>
" tasks
nnoremap <silent><Leader>; :Unite -silent -toggle
            \ grep:%::FIXME\|TODO\|NOTE\|XXX\|COMBAK\|@todo<CR>
" outlines (also ctags)
"nnoremap <silent><Leader>t :Unite -silent -vertical -winwidth=40
"            \ -direction=topleft -toggle outline<CR>
" junk files
  nnoremap <silent><Leader>d :Unite -silent junkfile/new junkfile<CR>

" menus {{{
let g:unite_source_menu_menus = {}

" menu prefix key (for all Unite menus) {{{
nnoremap [menu] <Nop>
nmap <LocalLeader> [menu]
" }}}

" menus menu
nnoremap <silent>[menu]u :Unite -silent -winheight=20 menu<CR>
" files and dirs menu {{{
let g:unite_source_menu_menus.files = {
    \'description' : '          files & dirs                                          ⌘ [space]o',
    \}
let g:unite_source_menu_menus.files.command_candidates = [
    \['▷ open file                                                  ⌘ ,o',   'Unite -start-insert file'],
    \['▷ open more recently used files                              ⌘ ,m',   'Unite file_mru'],
    \['▷ open file with recursive search                            ⌘ ,O',   'Unite -start-insert file_rec/async'],
    \['▷ edit new file',                                                     'Unite file/new'],
    \['▷ search directory',                                                  'Unite directory'],
    \['▷ search recently used directories',                                  'Unite directory_mru'],
    \['▷ search directory with recursive search',                            'Unite directory_rec/async'],
    \['▷ make new directory',                                                'Unite directory/new'],
    \['▷ change working directory',                                          'Unite -default-action=lcd directory'],
    \['▷ know current working directory',                                    'Unite output:pwd'],
    \['▷ junk files                                                 ⌘ ,d',   'Unite junkfile/new junkfile'],
    \['▷ save as root                                               ⌘ :w!!', 'exe "write !sudo tee % >/dev/null"'],
    \['▷ quick save                                                 ⌘ ,w',   'normal ,w'],
    \['▷ open vimfiler                                              <F8>',   'VimFiler'],
    \]
nnoremap <silent>[menu]o :Unite -silent -winheight=17 -start-insert menu:files<CR>
" }}}
" file searching menu {{{
let g:unite_source_menu_menus.grep = {
    \ 'description' : '           search files                                          ⌘ [space]a',
    \}
let g:unite_source_menu_menus.grep.command_candidates = [
    \['▷ grep (ag → ack → grep)                                     ⌘ ,a',   'Unite -no-quit grep'],
    \['▷ find',                                                              'Unite find'],
    \['▷ locate',                                                            'Unite -start-insert locate'],
    \['▷ vimgrep (very slow)',                                               'Unite vimgrep'],
    \]
nnoremap <silent>[menu]a :Unite -silent menu:grep<CR>
" }}}
" buffers, tabs & windows menu {{{
let g:unite_source_menu_menus.navigation = {
    \ 'description' : '     navigate by buffers, tabs & windows                   ⌘ [space]b',
    \}
let g:unite_source_menu_menus.navigation.command_candidates = [
    \['▷ buffers                                                    ⌘ ,b',   'Unite buffer'],
    \['▷ tabs                                                       ⌘ ,B',   'Unite tab'],
    \['▷ windows',                                                           'Unite window'],
    \['▷ location list',                                                     'Unite location_list'],
    \['▷ quickfix',                                                          'Unite quickfix'],
    \['▷ resize windows                                             ⌘ C-C C-W', 'WinResizerStartResize'],
    \['▷ close current window                                       ⌘ ,k',   'close'],
    \['▷ toggle quickfix window                                     ⌘ ,q',   'normal ,q'],
    \['▷ delete buffer                                              ⌘ ,K',   'bd'],
    \]
nnoremap <silent>[menu]b :Unite -silent menu:navigation<CR>
" }}}
" buffer internal searching menu {{{
let g:unite_source_menu_menus.searching = {
    \ 'description' : '      searchs inside the current buffer                     ⌘ [space]f',
    \}
let g:unite_source_menu_menus.searching.command_candidates = [
    \['▷ search line                                                ⌘ ,f',   'Unite -auto-preview -start-insert line'],
    \['▷ search word under the cursor                               ⌘ [space]8', 'UniteWithCursorWord -no-split -auto-preview line'],
    \['▷ search outlines & tags (ctags)                             ⌘ ,t',   'Unite -vertical -winwidth=40 -direction=topleft -toggle outline'],
    \['▷ search marks',                                                      'Unite -auto-preview mark'],
    \['▷ search folds',                                                      'Unite -vertical -winwidth=30 -auto-highlight fold'],
    \['▷ search changes',                                                    'Unite change'],
    \['▷ search jumps',                                                      'Unite jump'],
    \['▷ search undos',                                                      'Unite undo'],
    \['▷ search tasks                                               ⌘ ,;',   'Unite -toggle grep:%::FIXME|TODO|NOTE|XXX|COMBAK|@todo'],
    \]
nnoremap <silent>[menu]f :Unite -silent menu:searching<CR>
" }}}
" yanks, registers & history menu {{{
let g:unite_source_menu_menus.registers = {
    \ 'description' : '      yanks, registers & history                            ⌘ [space]i',
    \}
let g:unite_source_menu_menus.registers.command_candidates = [
    \['▷ yanks                                                      ⌘ ,i',   'Unite history/yank'],
    \['▷ commands       (history)                                   ⌘ q:',   'Unite history/command'],
    \['▷ searches       (history)                                   ⌘ q/',   'Unite history/search'],
    \['▷ registers',                                                         'Unite register'],
    \['▷ messages',                                                          'Unite output:messages'],
    \]
nnoremap <silent>[menu]i :Unite -silent menu:registers<CR>
" }}}
" text edition menu {{{
let g:unite_source_menu_menus.text = {
    \ 'description' : '           text edition                                          ⌘ [space]e',
    \}
let g:unite_source_menu_menus.text.command_candidates = [
    \['▷ toggle search results highlight                            ⌘ ,eq',  'set invhlsearch'],
    \['▷ toggle line numbers                                        ⌘ ,l',   'call ToggleRelativeAbsoluteNumber()'],
    \['▷ toggle wrapping                                            ⌘ ,ew',  'call ToggleWrap()'],
    \['▷ show hidden chars                                          ⌘ ,eh',  'set list!'],
    \['▷ text statistics                                            ⌘ ,es',  'Unite output:normal\ ,es -no-cursor-line'],
    \['▷ show word frequency                                        ⌘ ,ef',  'Unite output:WordFrequency'],
    \]
nnoremap <silent>[menu]e :Unite -silent -winheight=20 menu:text <CR>
" }}}
" neobundle menu {{{
let g:unite_source_menu_menus.neobundle = {
    \ 'description' : '      plugins administration with neobundle                 ⌘ [space]n',
    \}
let g:unite_source_menu_menus.neobundle.command_candidates = [
    \['▷ neobundle',                                                         'Unite neobundle'],
    \['▷ neobundle log',                                                     'Unite neobundle/log'],
    \['▷ neobundle lazy',                                                    'Unite neobundle/lazy'],
    \['▷ neobundle update',                                                  'Unite neobundle/update'],
    \['▷ neobundle search',                                                  'Unite neobundle/search'],
    \['▷ neobundle install',                                                 'Unite neobundle/install'],
    \['▷ neobundle check',                                                   'Unite -no-empty output:NeoBundleCheck'],
    \['▷ neobundle docs',                                                    'Unite output:NeoBundleDocs'],
    \['▷ neobundle clean',                                                   'NeoBundleClean'],
    \['▷ neobundle list',                                                    'Unite output:NeoBundleList'],
    \]
nnoremap <silent>[menu]n :Unite -silent -start-insert menu:neobundle<CR>
" }}}
" git menu {{{
let g:unite_source_menu_menus.git = {
    \ 'description' : '            admin git repositories                                ⌘ [space]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ tig                                                        ⌘ ,gt',  'normal ,gt'],
    \['▷ git status             (fugitive)                          ⌘ ,gs',  'Gstatus'],
    \['▷ git diff               (fugitive)                          ⌘ ,gd',  'Gdiff'],
    \['▷ git commit             (fugitive)                          ⌘ ,gc',  'Gcommit'],
    \['▷ git log                (fugitive)                          ⌘ ,gl',  'exe "silent Glog | Unite -no-quit quickfix"'],
    \['▷ git log - all          (fugitive)                          ⌘ ,gL',  'exe "silent Glog -all | Unite -no-quit quickfix"'],
    \['▷ git blame              (fugitive)                          ⌘ ,gb',  'Gblame'],
    \['▷ git add/stage          (fugitive)                          ⌘ ,gw',  'Gwrite'],
    \['▷ git checkout           (fugitive)                          ⌘ ,go',  'Gread'],
    \['▷ git rm                 (fugitive)                          ⌘ ,gR',  'Gremove'],
    \['▷ git mv                 (fugitive)                          ⌘ ,gm',  'exe "Gmove " input("destino: ")'],
    \['▷ git push               (fugitive, buffer output)           ⌘ ,gp',  'Git! push'],
    \['▷ git pull               (fugitive, buffer output)           ⌘ ,gP',  'Git! pull'],
    \['▷ git command            (fugitive, buffer output)           ⌘ ,gi',  'exe "Git! " input("comando git: ")'],
    \['▷ git edit               (fugitive)                          ⌘ ,gE',  'exe "command Gedit " input(":Gedit ")'],
    \['▷ git grep               (fugitive)                          ⌘ ,gg',  'exe "silent Ggrep -i ".input("Pattern: ") | Unite -no-quit quickfix'],
    \['▷ git grep - messages    (fugitive)                          ⌘ ,ggm', 'exe "silent Glog --grep=".input("Pattern: ")." | Unite -no-quit quickfix"'],
    \['▷ git grep - text        (fugitive)                          ⌘ ,ggt', 'exe "silent Glog -S".input("Pattern: ")." | Unite -no-quit quickfix"'],
    \['▷ git init                                                   ⌘ ,gn',  'Unite output:echo\ system("git\ init")'],
    \['▷ git cd                 (fugitive)',                                 'Gcd'],
    \['▷ git lcd                (fugitive)',                                 'Glcd'],
    \['▷ git browse             (fugitive)                          ⌘ ,gB',  'Gbrowse'],
    \]
nnoremap <silent>[menu]g :Unite -silent -winheight=26 -start-insert menu:git<CR>
" }}}
" code menu {{{
let g:unite_source_menu_menus.code = {
    \ 'description' : '           code tools                                            ⌘ [space]p',
    \}
let g:unite_source_menu_menus.code.command_candidates = [
    \['▷ view current diff                          (patchreview)',          'DiffReview'],
    \['▷ run python code                            (pymode)        ⌘ ,r',   'Pyrun'],
    \['▷ show docs for the current word             (pymode)        ⌘ K',    'normal K'],
    \['▷ insert a breakpoint                        (pymode)        ⌘ ,B',   'normal ,B'],
    \['▷ togle pylint revison                       (pymode)',               'PyLintToggle'],
    \['▷ rope autocompletion                        (rope)          C-[espacio]', 'RopeCodeAssist'],
    \['▷ go to definition                           (rope)          C-c g', 'call pymode#rope#goto_definition()'],
    \['▷ reorganize imports                         (rope)          C-c r o', 'call pymode#rope#organize_imports()'],
    \['▷ refactorize - rename                       (rope)          C-c r r', 'call pymode#rope#rename()'],
    \['▷ refactorize - extract variable             (rope)          C-c r l', 'call pymode#rope#extract_variable()'],
    \['▷ refactorize - extract method               (rope)          C-c r m', 'call pymode#rope#extrace_method()'],
    \['▷ refactorize - inline                       (rope)          C-c r i', 'call pymode#rope#inline()'],
    \['▷ refactorize - move                         (rope)          C-c r v', 'call pymode#rope#move()'],
    \['▷ refactorize - restructure                  (rope)          ⌘ C-C r x', 'RopeRestructure'],
    \['▷ refactorize - use function                 (rope)          C-c r u', 'call pymode#rope#use_function()'],
    \['▷ refactorize - introduce factory            (rope)          ⌘ C-C r f', 'RopeIntroduceFactory'],
    \['▷ refactorize - change signature             (rope)          C-c r s', 'call pymode#rope#signature()'],
    \['▷ refactorize - rename current module        (rope)          C-c r 1 r', 'call pymode#rope#rename_module()'],
    \['▷ refactorize - move current module          (rope)          ⌘ C-C r 1 m', 'RopeMoveCurrentModule'],
    \['▷ refactorize - module to package            (rope)          C-c r 1 p', 'call pymode#rope#module_to_package()'],
    \['▷ show docs for current word                 (rope)          C-c r a d', 'call pymode#rope#show_doc()'],
    \['▷ ALE check                                  (ALE)',                  'ALELint'],
    \['▷ ALE go to definition                       (ALE)',                  'ALEGoToDefinition'],
    \['▷ ALE go to definition in tab                (ALE)',                  'ALEGoToDefinitionInTab'],
    \['▷ ALE find references                        (ALE)',                  'ALEFindReferences'],
    \['▷ ALE hover information                      (ALE)',                  'ALEHover'],
    \['▷ ALE suggest fixes                          (ALE)',                  'ALEFixSuggest'],
    \['▷ ALE fix                                    (ALE)',                  'ALEFix'],
    \['▷ run coverage2                              (coveragepy)',           'call system("coverage2 run ".bufname("%")) | Coveragepy report'],
    \['▷ run coverage3                              (coveragepy)',           'call system("coverage3 run ".bufname("%")) | Coveragepy report'],
    \['▷ toggle coverage report                     (coveragepy)',           'Coveragepy session'],
    \['▷ toggle coverage marks                      (coveragepy)',           'Coveragepy show'],
    \['▷ count lines of code',                                               'Unite -default-action= output:call\\ LinesOfCode()'],
    \['▷ toggle indent lines                                        ⌘ ,L',   'IndentLinesToggle'],
    \]
nnoremap <silent>[menu]p :Unite -silent -winheight=42 menu:code<CR>
" }}}
" markdown menu {{{
function! s:RegisterMarkdownMenu()
    let g:unite_source_menu_menus.markdown = {
        \ 'description' : '       preview markdown extra docs                           ⌘ [space]k',
        \}
    let g:unite_source_menu_menus.markdown.command_candidates = [
        \['▷ preview',                                                           'Me'],
        \['▷ refresh',                                                           'Mer'],
        \]
    nnoremap <silent>[menu]k :Unite -silent menu:markdown<CR>
endfunction
au FileType markdown,mkd call s:RegisterMarkdownMenu()
" }}}
" sessions menu {{{
let g:unite_source_menu_menus.sessions = {
    \ 'description' : '       sessions                                              ⌘ [space]h',
    \}
let g:unite_source_menu_menus.sessions.command_candidates = [
    \['▷ load session',                                                      'Unite session'],
    \['▷ make session (default)',                                            'UniteSessionSave'],
    \['▷ make session (custom)',                                             'exe "UniteSessionSave " input("name: ")'],
    \]
nnoremap <silent>[menu]h :Unite -silent menu:sessions<CR>
" }}}
" bookmarks menu {{{
let g:unite_source_menu_menus.bookmarks = {
    \ 'description' : '      bookmarks                                             ⌘ [space]m',
    \}
let g:unite_source_menu_menus.bookmarks.command_candidates = [
    \['▷ open bookmarks',                                                    'Unite bookmark:*'],
    \['▷ add bookmark',                                                      'UniteBookmarkAdd'],
    \]
nnoremap <silent>[menu]m :Unite -silent menu:bookmarks<CR>
" }}}
" colorv menu {{{
function! GetColorFormat()
    let formats = {'r' : 'RGB',
                  \'n' : 'NAME',
                  \'s' : 'HEX',
                  \'ar': 'RGBA',
                  \'pr': 'RGBP',
                  \'pa': 'RGBAP',
                  \'m' : 'CMYK',
                  \'l' : 'HSL',
                  \'la' : 'HSLA',
                  \'h' : 'HSV',
                  \}
    let formats_menu = ["\n"]
    for [k, v] in items(formats)
        call add(formats_menu, "  ".k."\t".v."\n")
    endfor
    let fsel = get(formats, input('Choose a format: '.join(formats_menu).'? '))
    return fsel
endfunction

function! GetColorMethod()
    let methods = {
                   \'h' : 'Hue',
                   \'s' : 'Saturation',
                   \'v' : 'Value',
                   \'m' : 'Monochromatic',
                   \'a' : 'Analogous',
                   \'3' : 'Triadic',
                   \'4' : 'Tetradic',
                   \'n' : 'Neutral',
                   \'c' : 'Clash',
                   \'q' : 'Square',
                   \'5' : 'Five-Tone',
                   \'6' : 'Six-Tone',
                   \'2' : 'Complementary',
                   \'p' : 'Split-Complementary',
                   \'l' : 'Luma',
                   \'g' : 'Turn-To',
                   \}
    let methods_menu = ["\n"]
    for [k, v] in items(methods)
        call add(methods_menu, "  ".k."\t".v."\n")
    endfor
    let msel = get(methods, input('Choose a method: '.join(methods_menu).'? '))
    return msel
endfunction

let g:unite_source_menu_menus.colorv = {
    \ 'description' : '         color management                                      ⌘ [space]c',
    \}
let g:unite_source_menu_menus.colorv.command_candidates = [
    \['▷ open colorv                                                ⌘ ,cv',  'ColorV'],
    \['▷ open colorv with the color under the cursor                ⌘ ,cw',  'ColorVView'],
    \['▷ preview colors                                             ⌘ ,cpp', 'ColorVPreview'],
    \['▷ color picker                                               ⌘ ,cd',  'ColorVPicker'],
    \['▷ edit the color under the cursor                            ⌘ ,ce',  'ColorVEdit'],
    \['▷ edit the color under the cursor (and all the concurrences) ⌘ ,cE',  'ColorVEditAll'],
    \['▷ insert a color                                             ⌘ ,cii', 'exe "ColorVInsert " .GetColorFormat()'],
    \['▷ color list relative to the current                         ⌘ ,cgh', 'exe "ColorVList " .GetColorMethod() "
        \ ".input("number of colors? (optional): ")
        \ " ".input("number of steps?  (optional): ")'],
    \['▷ show colors list (Web W3C colors)                          ⌘ ,cn',  'ColorVName'],
    \['▷ choose color scheme (ColourLovers, Kuler)                  ⌘ ,css', 'ColorVScheme'],
    \['▷ show favorite color schemes                                ⌘ ,csf', 'ColorVSchemeFav'],
    \['▷ new color scheme                                           ⌘ ,csn', 'ColorVSchemeNew'],
    \['▷ create hue gradation between two colors',                           'exe "ColorVTurn2 " " ".input("Color 1 (hex): ")" ".input("Color 2 (hex): ")'],
    \]
nnoremap <silent>[menu]c :Unite -silent menu:colorv<CR>
" }}}
" vim menu {{{
let g:unite_source_menu_menus.vim = {
    \ 'description' : '            vim                                                   ⌘ [space]v',
    \}
let g:unite_source_menu_menus.vim.command_candidates = [
    \['▷ choose colorscheme',                                            'Unite colorscheme -auto-preview'],
    \['▷ mappings',                                                      'Unite mapping -start-insert'],
    \['▷ edit configuration file (vimrc)',                               'edit $MYVIMRC'],
    \['▷ choose filetype',                                               'Unite -start-insert filetype'],
    \['▷ vim help',                                                      'Unite -start-insert help'],
    \['▷ vim commands',                                                  'Unite -start-insert command'],
    \['▷ vim functions',                                                 'Unite -start-insert function'],
    \['▷ vim runtimepath',                                               'Unite -start-insert runtimepath'],
    \['▷ vim command output',                                            'Unite output'],
    \['▷ unite sources',                                                 'Unite source'],
    \['▷ kill process',                                                  'Unite -default-action=sigkill -start-insert process'],
    \['▷ launch executable (dmenu like)',                                'Unite -start-insert launcher'],
    \['▷ clear powerline cache',                                         'PowerlineClearCache'],
    \]
nnoremap <silent>[menu]v :Unite menu:vim -silent -start-insert<CR>
" }}}
" }}}

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate','ignore_pattern', join(['\.git/', '\.tmp/', '\.bzr/', '\.hg/', 'tmp/', 'bundle/'], '\|'))

let g:unite_source_history_yank_enable = 1
let g:unite_enable_start_insert = 0
let g:unite_enable_short_source_mes = 0
let g:unite_force_overwrite_statusline = 0
let g:unite_prompt = '>>> '
let g:unite_marked_icon = '✓'
" let g:unite_candidate_icon = '∘'
let g:unite_winheight = 15
let g:unite_update_time = 200
let g:unite_split_rule = 'botright'
let g:unite_data_directory = $VIMHOME.'/.tmp/unite'
let g:unite_source_buffer_time_format = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_file_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '

if executable('rg')
    let g:unite_source_grep_command='rg'
    let g:unite_source_grep_default_opts='--hidden --no-heading --vimgrep -S'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
elseif executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup -a -S'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
elseif executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-group --no-color'
    let g:unite_source_grep_recursive_opt=''
    let g:unite_source_grep_search_word_highlight = 1
endif

let g:junkfile#directory=expand($VIMHOME."/.tmp/junk")

" make this dir if no exists previously
silent! call MakeDirIfNoExists(expand(unite_data_directory)."/session/")

" }}}

" Строка статуса {{{
" Перезагружать Powerline, во избежание артефактов
autocmd! BufWritePost vimrc source % | call Pl#Load()

" let g:Powerline_cache_file = $HOME.'/.vim/.tmp/Powerline.cache'
let g:Powerline_symbols = 'unicode'
let g:Powerline_mode_n = ' N '
let g:Powerline_mode_y = ' I '
let g:Powerline_mode_R = ' R '
let g:Powerline_mode_v = ' V '
let g:Powerline_mode_V = ' V-LINE '
let g:Powerline_mode_cv = ' V-BLOCK '
let g:Powerline_mode_s = ' S '
let g:Powerline_mode_S = ' S-LINE '
let g:Powerline_mode_cs = ' S-BLOCK '
set noshowmode
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
" }}}

" Постоянный undo и бэкапы {{{
function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p", 0700)
    endif
endfunction

set undofile " Включение persistent undo
set undolevels=10000
set backup " Сохранять бэкап file~
let &undodir = $VIMHOME."/.tmp/undofiles/" " Хранить undo там
let &backupdir = $VIMHOME."/.tmp/backupfiles/" " Храним бэкапы тут
let &backupskip = &backupskip . "," . &backupdir . '/*' " Не бэкапим содержимое бэкапов
let &directory = $VIMHOME."/.tmp/swap/" " место под своп-файл

silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&directory)

" История всех правок
"if isdirectory(s:backupdir . '/.hg')
"	au BufWritePost * call system("hg add ".&backupdir.expand(bufname('%')). &backupext )
"	au BufWritePost * call system("hg commit \".&backupdir." -m Fix")
"endif
" }}}

" Комментирование кода {{{

augroup plugin_commentary
    au!
    au FileType python setlocal commentstring=#%s
    au FileType htmldjango setlocal commentstring={#\ %s\ #}
    au FileType puppet setlocal commentstring=#\ %s
    au FileType python,cpp nmap <Leader>c <Plug>CommentaryLine
    au FileType python,cpp xmap <Leader>c <Plug>Commentary
augroup END

" }}}

" Настройки Indexer {{{
let g:indexer_indexerListFilename = $VIMHOME."/indexer_files"
let g:indexer_enableWhenProjectDirFound = 1
let g:indexer_tagsDirname = $VIMHOME."/tags/projects"
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q --languages=c++,c"
let g:indexer_ctagsDontSpecifyFilesIfPossible = 1
let g:indexer_disableCtagsWarning=1
" }}}

" Настройки VCSCommand {{{
nmap svnci :VCSCommit<cr>
nmap svnup :VCSUpdate<cr>
nmap svnin :VCSInfo<cr>
" }}}

" List {{{
au FileType vim,sh,zsh,bash,html,css,sass,javascript,php,python,ruby,psql setlocal list
au FileType diff setlocal list listchars+=trail:\ " Выкинуть trailing пробелы
" }}}

" Whitespace {{{
function! s:StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endfunction

au FileType html,css,sass,javascript,php,ruby,psql,vim,cpp,c au BufWritePre <buffer> :silent! call <SID>StripTrailingWhitespace()

" Подсвечивать проблемные пробелы (пробелы перед табуляцией
hi RedundantSpaces ctermfg=214 ctermbg=160 cterm=bold
match RedundantSpaces / \+\ze\t/
" }}}

" Markdown {{{

" map <LocalLeader>mp :Me<CR>
" map <LocalLeader>mr :Mer<CR>

" let g:VMEPextensions = ['extra', 'codehilite']
" let g:VMEPhtmlreader= '/usr/bin/chromium-browser'

" }}}

" JSON {{{
autocmd BufNewFile,BufRead *.json set ft=json

augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END
" }}}

" Golang {{{
augroup golang
    au FileType go set sts=8 ts=8 sw=8 noet
" }}}

" Бинарные файлы {{{
" для редактирования бинарников надо использовать vim -b,
" при этом они пропускаются через xxd-format
"augroup Binary
"	au!
"	au BufReadPre  *.bin.*.rom,*.ROM let &bin=1
"	au BufReadPost *.bin,*.rom,*.ROM if &bin | %!xxd
"	au BufReadPost *.bin,*.rom,*.ROM set ft=xxd | endif
"	au BufWritePre *.bin,*.rom,*.ROM if &bin | %!xxd -r
"	au BufWritePre *.bin,*.rom,*.ROM endif
"	au BufWritePost *.bin,*.rom,*.ROM if &bin | %!xxd
"	au BufWritePost *.bin,*.rom,*.ROM set nomod | endif
"augroup END

map <F6> <Plug>HexManager<CR>

command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
    if empty(a:arg)
        if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
            let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        else
            let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
        endif
        try
            execute a:line1 . ',' . a:line2 . cmd
        catch
            echo 'Error: No decimal number found'
        endtry
    else
        echo printf('%x', a:arg + 0)
    endif
endfunction
" }}}

" Питон :( {{{
let python_highlight_all = 1
let g:pydiction_location="$VIMHOME/ftplugin/complete-dict"
let g:pep8_ignore="E5" " Игнорируем слишком длинные строки
let g:pymode_run = 0 " Выключить запуск скриптов в python-mode
let g:pymode_rope = 1 " использовать rope
let g:pymode_breakpoint = 0 " скрипт breakpoint'ов не нужен
let g:pymode_virtualenv = 0 " venv тоже не нужен
let g:pymode_options = 0 " отключить модификацию complete/formatoptions/number/nowrap/textwidth
let g:pymode_lint_checkers = ["pyflakes", "pep8", "mccabe"]
"let g:pymode_lint_checker = 'pylint,pep8,mccabe,pep257'
let g:pymode_lint_ignore = "E5,W503"
let g:pymode_lint_onfly = 1 " Проверять код на лету
let g:pymode_lint_jump = 0 " Не прыгать на ближайшую ошибку
let g:pymode_lint_hold = 0 " Не прыгать на quickfix
let g:pymode_lint_maxheight = 4 " Максимальная высота cwindow pylint
let g:pymode_rope_always_show_complete_menu = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_completion_bind = '<C-Space>'

let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1

" let g:jedi#auto_vim_configuration = 0
" let g:jedi#popup_on_dot = 0
" let g:jedi#completions_command = "<C-Tab>"
" let g:jedi#popup_select_first = 1 " выбирать первый же вариант при автокомплите

let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_mypy_executable = 'python3 -m mypy'

nmap <F9> :VoomToggle python<cr><tab>
imap <F9> <esc>:VoomToggle python<cr><tab>
" }}}

" indentLine {{{
map <silent> <Leader>L :IndentLinesToggle<CR>
let g:indentLine_enabled = 0
let g:indentLine_char = '┊'
let g:indentLine_color_term = 239
"}}}

" PHP {{{
au FileType php  imap <C-P> <ESC>:Dox<CR>
au FileType php  nmap <C-P> :Dox<CR>
au FileType php  vmap <C-P> :Dox<CR>
" }}}

" asyncomplete {{{
" let g:asyncomplete_remove_duplicates = 1
" }}}

" Rust {{{
let g:rust_folding = 2
let g:rust_bang_comment_leader = 1
let g:racer_cmd = $HOME.'/.cargo/bin/racer'
let g:racer_experimental_completer = 1
" let $RUST_SRC_PATH = $VIMHOME.'/bundle/rust/src'
" let g:ycm_rust_src_path = $VIMHOME.'/bundle/rust/src'
let $RUST_SRC_PATH = $HOME."/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
let g:ycm_rust_src_path = $RUST_SRC_PATH
let g:ftplugin_rust_source_path = $RUST_SRC_PATH

" au User lsp_setup call lsp#register_server({
"     \ 'name': 'rls',
"     \ 'cmd': {server_info->['rls']},
"     \ 'whitelist': ['rust'],
"     \ })
" }}}

" C/C++ {{{
augroup cprog
	" Remove all cprog autocommands
	au!

	" When starting to edit a file:
	"   For C and C++ files set formatting of comments and set C-indenting on.
	"   For other files switch it off.
	"   Don't change the order, it's important that the line with * comes first.
	au FileType c,cpp  set formatoptions=tcql nocindent comments&
	au FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
	au BufNewFile,BufRead *.hpp,*.cpp,*.h set syntax=cpp
	"  autocmd FileType c,cpp  hi Comment ctermfg=grey
	au FileType c,cpp  imap <C-P> <ESC>:Dox<CR>
	au FileType c,cpp  nmap <C-P> :Dox<CR>
	au FileType c,cpp  vmap <C-P> :Dox<CR>
	" Привет, ctags!
	au FileType c,cpp  nmap <F10> <esc>:!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q --languages=c++,c .<cr>
	au FileType c,cpp  imap <F10> <esc>:!ctags -R --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q --languages=c++,c .<cr>
	au FileType c,cpp,h set makeprg=LANG=C\ make
	au FileType cpp    set foldnestmax=1
	au CursorMovedI,InsertLeave c,cpp if pumvisible() == 0|silent! pclose|endif
	au FileType c,cpp,h nmap <C-j> :cn<Cr>zvzz:cc<Cr>
	au FileType c,cpp,h nmap <C-k> :cp<Cr>zvzz:cc<Cr>
augroup END
" }}}

" Форматирование C/C++ кода {{{
function! AstyleReformat() range
	let l:curline = line('.')
	let firstline = a:firstline
	let endline = a:lastline
	exec firstline . "," . endline ."! astyle --style=1tbs -s4lNdk3z2"
	call cursor(l:curline, 1)
endfunction

vmap astyle :call AstyleReformat()<cr>
nmap astyle :1,$call AstyleReformat()<cr>
"}}}

" Настройки окна помощи {{{
" function! s:SetupHelpWindow()
" 	wincmd L
" 	vertical resize 80
" 	setl nonumber winfixwidth colorcolumn=
"
" 	let b:stl = "#[Branch] HELP#[BranchS] [>] #[FileName]%<%t #[FileNameS][>>]%* %=#[LinePercentS][<<]#[LinePercent] %p%% " " Set custom statusline
"
" 	nnoremap <buffer> <Space> <C-]> " Space selects subject
" 	nnoremap <buffer> <BS>    <C-T> " Backspace to go back
" endfunction
" au Filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
" au FileType help au BufEnter,BufWinEnter <buffer> call <SID>SetupHelpWindow()
" }}}

" Автокомплит {{{

let g:neocomplete#enable_at_startup = 0 " включать автокомплит
let g:neocomplete#enable_ignore_case = 0 " игнорировать регистр
let g:neocomplete#enable_smart_case = 0 " использовать умную работу с регистром
let g:neocomplete#enable_quick_match = 0 " позволять писать c-v для получения completion-variant
let g:neocomplete#enable_auto_select = 1 " Автоматически выбирать первый вариант
let g:neocomplete#enable_camel_case_completion = 1 " AE ->ArgumentsException
let g:neocomplete#disable_auto_complete = 0 " Не дополнять автоматически
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#max_list = 30
let g:neocomplete#auto_completion_start_length = 3 " предлагать дополнения, начиная с 3 символов
let g:neocomplete#manual_completion_start_length = 2 " вручную дополнять можно и с двух
let g:neocomplete#min_keyword_length = 3
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#data_directory = $VIMHOME.'/.tmp/neocomplete'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown,mkd setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" }}}

" Doxygen {{{
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_briefTag_className="yes"
" }}}

" ALE {{{
let g:ale_lint_on_enter = 0
let g:ale_completion_enabled = 0
" unlike syntastic, ALE has no sphinx checker
" let g:ale_linter_aliases = {'rst': 'sphinx'}
let g:ale_linter_aliases = {'bash': 'sh'}
let g:ale_linters = {
    \ 'c': [],
    \ 'cpp': [],
    \ 'python': ['flake8', 'mypy'],
    \ }
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_style_error = '⚡'
let g:ale_sign_style_warning = '⚡'
let g:ale_echo_delay = 100
let g:ale_lint_delay = 500
let g:ale_set_balloons = 1
augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END
" }}}

" {{{ VimFiler
nmap <F8> :VimFilerExplorer<cr>
imap <F8> <esc>:VimFilerExplorer<cr>
" }}}

" Информация о пользователе {{{
" Для сниппетов
let g:snips_author="Vsevolod Velichko <torkvemada@sorokdva.net>"
" Doxygen
let g:DoxygenToolkit_authorName="Vsevolod Velichko <torkvemada@sorokdva.net>"
" Po.vim
let g:po_translator = "Vsevolod Velichko <torkvemada@sorokdva.net>"
" }}}

" vim: set fdm=marker:

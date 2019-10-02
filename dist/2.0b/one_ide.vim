function! s:OIPath(path)
	if has('win32')
	  return substitute(a:path, "/",  "\\" , "g")
	else
	  return substitute(a:path, "\\",  "/" , "g")
	endif
endfunction

let s:current_file = expand("<sfile>:h")

exec "source " . s:current_file . s:OIPath("/one_plugins.vim")

if (index(One_Ide_options, 'php') >= 0)
	exec "source " . s:current_file . s:OIPath("/one_php.vim")
endif

if (index(One_Ide_options, 'js') >= 0)
	exec "source " . s:current_file . "/one_javascript.vim"
endif

exec "source " . s:current_file . "/onefunctions.vim"
exec "source " . s:current_file . "/one.vim"
exec "source " . s:current_file . "/one_ide_paths.vim"
exec "source " . s:current_file . "/scripts.vim"
exec "source " . s:current_file . "/colors.vim"

"---------------------------------------------------------------------- ONE IDE ----------------------------------------------------------------------

"Allow change buffer without saving
set hidden

"Define delete without yank
nnoremap x "_dl
vnoremap x "_d

"prevent yank the last copy text
vnoremap p "_s<ESC>p
vnoremap P "_dP

"Define better toggle insermode to normalmode
inoremap <C-f> <ESC>
vnoremap <C-f> <ESC>
nnoremap <C-f> :noh<CR><ESC>

"Define highline on cursor line
:set cursorline

"Define tabs only use spaces
set expandtab

"Define  indenting is 4 spaces
set shiftwidth=4
set autoindent

" Highlight all search pattern matches
set hlsearch

"value  that will be inserted when the tab key is pressed
set tabstop=4

" refactoy tab to spaces
if !&modifiable
	autocmd VimEnter * retab
endif

"does nothing more than copy the indentation from the previous line, when starting a new line.

" Show line numbers
set number

"Define active mouse
set mouse=a

" Allow insert the only occurrence and preview data from multiples
set completeopt=menu,preview

" Indent with tab
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

"indent a group visual
vmap <Tab> >gv
vmap <S-Tab> <gv

vnoremap < <gv
vnoremap > >gv

autocmd VimEnter * set guioptions -=T

set pastetoggle=<F10>
inoremap <C-v> <F10><C-r>+<F10>
vnoremap <C-C> "+y

"Fix any backspace problem (usually on windows)
set backspace=indent,eol,start

set encoding=utf-8

ca Ack Ack!
ca ack Ack!

map gn :bn<cr>
map gp :bp<cr>
map gd :Bclose<CR>
map gD :Bclose!<CR>

"Case-insensitive when searching
set ignorecase                  

nnoremap <f3> :mksession!<CR>
nnoremap <f4> ~\vimfiles\session.vim<CR>

if filereadable(s:OIPath(s:current_file . "/../../../nerdtree/plugin/NERD_tree.vim"))

    "---------------------------------------------------------------------- PLUGIN neosnippet ----------------------------------------------------------------------

    " Plugin key-mappings.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><C-k> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
    set conceallevel=0 concealcursor=niv
    endif

    "---------------------------------------------------------------------- PLUGIN vim-anzu ----------------------------------------------------------------------
    " mapping
    nmap n <Plug>(anzu-n-with-echo)
    nmap N <Plug>(anzu-N-with-echo)
    nmap * <Plug>(anzu-star-with-echo)
    nmap # <Plug>(anzu-sharp-with-echo)

    " clear status
    nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

    " statusline
    set statusline=%{anzu#search_status()}
    "---------------------------------------------------------------------- PLUGIN deoplete ----------------------------------------------------------------------

    let g:deoplete#auto_completion_start_length = 2
    let g:deoplete#sources#padawan#auto_update  = 1
    let g:deoplete#enable_refresh_always        = 1

    " Allow insert the only occurrence and preview data from multiples
    set completeopt=menu,preview

    autocmd VimEnter * call deoplete#custom#option({
        \ 'auto_complete_delay': 200,
        \ 'auto_complete': 1,
        \ 'smart_case': v:true,
        \ })


    function! Multiple_cursors_before()
        let b:deoplete_disable_auto_complete = 1
    endfunction

    function! Multiple_cursors_after()
        let b:deoplete_disable_auto_complete = 0
    endfunction

    "---------------------------------------------------------------------- PLUGIN CTRLP ----------------------------------------------------------------------

    let g:cctrlp_show_hidden = 1
    let g:ctrlp_ag_ignores   = '--ignore .git
        \ --ignore "deps/*"
        \ --ignore "_build/*"
        \ --ignore "node_modules/*"'
    nnoremap <leader>ca :CtrlPagLocate
    nnoremap <leader>cp :CtrlPagPrevious<cr>

    "---------------------------------------------------------------------- PLUGIN ALE ----------------------------------------------------------------------

    let g:ale_linters                                      = {
    \   'javascript': 'all',
    \ 	'php' : 'all',
    \   'html': 'all',
    \	'xhtml' : 'all',
    \	'xml' : 'all'
    \}
    let g:ale_fixers                                       = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \}
    let g:ale_linters_explicit                             = 1
    let g:ale_fix_on_save                                  = 1

    "---------------------------------------------------------------------- PLUGIN TABBAR ----------------------------------------------------------------------

    nmap <F7> :TagbarToggle<CR>

    "---------------------------------------------------------------------- PLUGIN GUTENTAGS And Ctags ----------------------------------------------------------------------

    let g:gutentags_project_root             = ['.one-project']
    let g:gutentags_ctags_exclude            = ['*.css', '*.html', '*.swp','\~$','.un\~$', '*.swo']
    let g:gutentags_define_advanced_commands = 1
    map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
    "---------------------------------------------------------------------- PLUGIN NERDTREE ----------------------------------------------------------------------

    let g:NERDTreeChDirMode   = 1
    let NERDTreeShowBookmarks = 1
    let NERDTreeShowHidden    = 1
    let NERDTreeIgnore        = ['.swp$','\~$','.un\~$']

    "---------------------------------------------------------------------- PLUGIN AIRLINE ----------------------------------------------------------------------

    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:nerdtree_tabs_open_on_gui_startup    = 1

    "If you have installed powerline fonts
    let g:airline_powerline_fonts              = 1 "Set Arrow in ariline for use powerline fonts
    let g:airline#extensions#tabline#enabled   = 1

    "---------------------------------------------------------------------- PLUGIN color ----------------------------------------------------------------------

    autocmd VimEnter * colorscheme atom
	autocmd VimEnter * hi Cursor guifg=white guibg=orange
	
    "---------------------------------------------------------------------- PLUGIN vim-indent-guides ----------------------------------------------------------------------

    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level           = 1
    let g:indent_guides_guide_size            = 1
endif
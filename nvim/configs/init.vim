lua require("plugins")
lua require("init")

" Editor settings
"   colorscheme
colorscheme vscode

"   ruler
set colorcolumn=80
highlight ColorColumn ctermbg=8

"   spaces vs tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"   show whitespace
set list
set listchars=tab:»\ ,space:·
highlight NonText ctermfg=8

"   highlight all trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

"   remove all trailing whitespaces
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"   CPPman
function! s:JbzCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction
command! JbzCppMan :call s:JbzCppMan()

au FileType cpp nnoremap <buffer>K :JbzCppMan<CR>

"   show line numbers
set number
set cursorline
set cursorlineopt=number,line
highlight LineNr ctermfg=8
highlight CursorLineNr ctermfg=7

" NERDTree settings
nnoremap <silent> <expr> fo g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" Code completions
"   coq settings
lua << EOF
vim.g.coq_settings = {
    ["auto_start"] = "shut-up",
    ["keymap.pre_select"] = true,
    ["keymap.recommended"] = false,
    ["display.preview.positions"] = { east = 1, south = 2, west = 3, north = 4 },
    ["display.ghost_text.enabled"] = false,
}
EOF
"   coq keybindings
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <Tab>   pumvisible() ? (complete_info().selected == -1 ? "\<C-e><Tab>" : "\<C-y>") : "\<Tab>"
ino <silent><expr> <CR>    pumvisible() ? "\<C-n>" : "\<CR>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"

"   change cmd completion to stop at last common match.
set wildmode=longest,list,full
set wildmenu

"   gutentag settings
set tags=./tags;
let g:gutentags_ctags_exclude_wildignore = 1
let g:gutentags_ctags_exclude = [
    \'node_modules', '_build', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
    \'*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls', '*.ui']

"   lsp configurations
lua << EOF
local lsp = require("lspconfig")
local coq = require("coq")
lsp.cmake.setup(coq.lsp_ensure_capabilities()) -- pip install cmake-language-server
lsp.pyright.setup(coq.lsp_ensure_capabilities()) -- pip install pyright
lsp.ccls.setup(coq.lsp_ensure_capabilities()) -- sudo apt install ccls
EOF

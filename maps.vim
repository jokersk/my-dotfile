nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
nnoremap <silent><leader>fr <cmd>Telescope live_grep<cr>
nnoremap <silent> <C-b> <cmd>lua require'telescope.builtin'.buffers{}<CR>
nnoremap <Leader>fc :lua require'telescope.builtin'.git_status{}<cr>
nnoremap <Leader>gb :lua require'telescope.builtin'.git_branches{}<cr>
nnoremap <Leader>gc :lua require'telescope.builtin'.git_commits{}<cr>
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> s <cmd>:w<CR>
nnoremap <silent> bd <cmd>:bd<CR>
nnoremap <silent> <C-j> <cmd>:e #<CR>
nnoremap <silent> <C-h> <cmd>:NvimTreeFindFileToggle<CR>
nnoremap <silent> <C-w>> <cmd>:vertical resize +40<CR>
nnoremap <silent> <C-w>< <cmd>:vertical resize -40<CR>
nnoremap <silent> cw caw
nnoremap <silent> dw daw
nnoremap <silent> yii yi{
nnoremap <silent> yaa ya{


let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'UltiSnips'


let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=['./UltiSnips']

let @q = 'i//'

:command FR :FlutterRestart
:command FC :FlutterLogClear

:command NC :NvimTreeClose
:command NF :NvimTreeFindFileToggle

command! AutoMethod lua require('auto_create_method').run()

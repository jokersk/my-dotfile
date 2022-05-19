if exists('g:load_methods') | finish | endif " prevent loading file twice
let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! Methods lua require'methods'.select()
command! Click lua require'methods'.click()
let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
let g:loaded_methods = 1

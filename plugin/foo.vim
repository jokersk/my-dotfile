if exists('g:load_foo') | finish | endif " prevent loading file twice
let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! Fs lua require'foo'.select()
command! Fd lua require'foo'.delete()
let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
let g:loaded_foo = 1

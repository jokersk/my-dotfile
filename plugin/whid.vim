if exists('g:load_whid') | finish | endif " prevent loading file twice
let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

command! Whid lua require'whid'.whid()
let &cpo = s:save_cpo " and restore after
unlet s:save_cpo
let g:loaded_whid = 1

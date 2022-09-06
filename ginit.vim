" Set Editor Font
if exists(':GuiFont')
    GuiFont! Hack Nerd Font Mono:h24
endif
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif
:GuiRenderLigatures 1

command! Big :execute ":set linespace=40 | :GuiFont! Hack Nerd Font Mono:h24" 
command! Small :execute "set linespace=20 | :GuiFont! Hack Nerd Font Mono:h14" 


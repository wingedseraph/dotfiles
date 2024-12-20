" Wez's VIM colors for Dark background
" vim:ts=2:sw=2:et:

hi clear
if exists("syntax on")
  syntax reset
endif
let g:colors_name = "wez"
let &background="dark"

hi SignColumn ctermbg=NONE guibg=NONE

" Grey
hi Normal       term=NONE ctermfg=7 guifg=#c3c3c3 guibg=NONE

if has("gui_running")
  hi Normal guibg=black
endif

" Yellow
hi Statement    term=bold cterm=None ctermfg=Yellow ctermbg=NONE
                \ gui=bold guifg=#ffff55 guibg=NONE

" Blue
hi PreProc      term=underline cterm=NONE ctermfg=blue ctermbg=NONE
                \ gui=NONE guifg=#8888ff guibg=NONE

" Cyan
hi Comment      term=bold cterm=italic ctermfg=LightCyan ctermbg=black
                \ gui=NONE guifg=#55cccc guibg=NONE

" Magenta
hi Constant     term=underline cterm=NONE ctermfg=DarkMagenta ctermbg=NONE
                \ gui=NONE guifg=#ff55ff guibg=NONE

" Red-ish; Orange in gui for better contrast
" Special chars are things like \n in a quoted string
hi Special      term=bold cterm=None ctermfg=DarkRed ctermbg=NONE
                \ gui=NONE guifg=Orange guibg=NONE
hi SpecialComment      term=bold cterm=italic ctermfg=DarkRed ctermbg=NONE
                \ gui=NONE guifg=Orange guibg=NONE
hi LineNr       term=bold cterm=bold ctermfg=DarkRed ctermbg=NONE
                \ gui=NONE guifg=Orange guibg=NONE

hi Folded       term=underline cterm=bold ctermfg=DarkCyan ctermbg=NONE
                \ gui=NONE guifg=#c0bfbf guibg=#000000

" Green for types
hi Type         term=underline cterm=None ctermfg=DarkGreen ctermbg=NONE
                \ gui=bold guifg=#55ff55 guibg=NONE

" Regular cyan for special function names etc.
hi Identifier   term=underline cterm=NONE ctermfg=DarkCyan ctermbg=NONE
                \ gui=NONE guifg=#55cccc guibg=NONE

hi Underlined   term=underline cterm=underline,bold ctermfg=DarkBlue
                \ gui=underline guifg=#5555ff

hi Ignore       term=NONE cterm=NONE ctermfg=black ctermbg=NONE
                \ gui=NONE guifg=bg guibg=NONE

hi Todo    term=standout cterm=italic ctermfg=Black ctermbg=LightCyan guifg=Orange guibg=#442222
hi IncSearch    term=reverse cterm=none ctermfg=Black ctermbg=DarkYellow
                \ gui=NONE guifg=black guibg=Orange
hi Search       term=reverse cterm=none ctermfg=Black ctermbg=DarkYellow
                \ gui=NONE guifg=black guibg=#cc55cc

hi Cursor       guifg=black guibg=#53ae71

hi Visual       term=reverse cterm=bold ctermfg=0 ctermbg=6
                \ gui=NONE guifg=black guibg=#55cccc

" NonText are things like the tilde after EOF. Greenish works well in GUI,
" and dark red in a terminal
hi NonText      term=NONE cterm=NONE ctermfg=1 gui=bold guifg=SeaGreen
hi SpecialKey   term=NONE cterm=NONE ctermfg=8 gui=NONE guifg=#666666 guibg=NONE

hi StatusLineNC cterm=NONE ctermbg=DarkGrey ctermfg=black gui=NONE
                \ guifg=black guibg=#555555
hi StatusLine   cterm=bold ctermbg=DarkBlue ctermfg=White gui=NONE
                \ guifg=#cccccc guibg=#5555cc

" pop-up menu
hi Pmenu        cterm=NONE ctermfg=0 ctermbg=4 gui=NONE
                \ guifg=black guibg=#5555cc
hi PmenuSel     cterm=NONE ctermfg=4 ctermbg=0 gui=NONE
                \ guifg=#cc55cc guibg=#2222aa
hi PmenuSbar    cterm=NONE ctermfg=5 ctermbg=0 gui=NONE
                \ guifg=black guibg=#cccccc
hi PmenuThumb   cterm=NONE ctermfg=1 ctermbg=6 gui=NONE
                \ guifg=black guibg=NONE

hi link String          Constant
hi link Character       Constant
hi link Number          Constant
hi link Boolean         Constant
hi link Float           Number
hi link Function        Identifier
hi link Conditional     Statement
hi link Repeat          Statement
hi link Label           Statement
hi link Operator        Statement
hi link Keyword         Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link Delimiter       Special
hi link SpecialComment  Special
hi link Debug           Special

hi SpellBad term=underline cterm=underline,bold ctermfg=4
                \ gui=underline guifg=#5555ff

hi DiffAdd ctermfg=NONE ctermbg=22
hi DiffChange ctermfg=NONE ctermbg=23
hi DiffText ctermfg=NONE ctermbg=23
hi DiffDelete ctermfg=NONE ctermbg=52


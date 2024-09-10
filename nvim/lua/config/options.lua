vim.opt.mousemoveevent = false

vim.opt.number = false
vim.opt.relativenumber = false
-- vim.opt.scrolloff = 0
vim.opt.wrap = false

vim.opt.splitkeep = "screen"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- use number of spaces to insert a <Tab>
vim.opt.expandtab = true

vim.opt.swapfile = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = false
vim.opt.cursorlineopt = "screenline"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 600

-- disable cursor-styling
-- vim.opt.guicursor = ""

vim.opt.termguicolors = true

vim.opt.helpheight = 999
vim.opt.cmdheight = 1
vim.opt.signcolumn = "yes"
vim.opt.confirm = true
vim.opt.diffopt = {       -- Option settings for diff mode.
   "filler",              -- Show filler lines.
   "vertical",            -- Start diff mode with vertical splits.
   "hiddenoff",           -- Do not use diff mode for a buffer when it becomes hidden.
   "foldcolumn:0",        -- Set the 'foldcolumn' option to 0.
   "algorithm:histogram", -- Use the specified diff algorithm.
}
vim.opt.foldopen = {      -- Specifies for which type of commands folds will be opened.
   "hor",                 -- Horizontal movements: "l", "w", "fx", etc.
   "mark",                -- Jumping to a mark: "'m", CTRL-O, etc.
   "percent",             -- % key.
   "quickfix",            -- ":cn", ":crew", ":make", etc.
   "tag",                 -- Jumping to a tag: ":ta", CTRL-T, etc.
   "undo",                -- Undo or redo: "u" and CTRL-R.
}
vim.opt.undofile = true
vim.opt.whichwrap:append("<>[]hl")
local langmap_keys = {
   "ёЁ;`~",
   "№;#",
   "йЙ;qQ",
   "цЦ;wW",
   "уУ;eE",
   "кК;rR",
   "еЕ;tT",
   "нН;yY",
   "гГ;uU",
   "шШ;iI",
   "щЩ;oO",
   "зЗ;pP",
   "хХ;[{",
   "ъЪ;]}",
   "фФ;aA",
   "ыЫ;sS",
   "вВ;dD",
   "аА;fF",
   "пП;gG",
   "рР;hH",
   "оО;jJ",
   "лЛ;kK",
   "дД;lL",
   [[жЖ;\;:]],
   [[эЭ;'\"]],
   "яЯ;zZ",
   "чЧ;xX",
   "сС;cC",
   "мМ;vV",
   "иИ;bB",
   "тТ;nN",
   "ьЬ;mM",
   [[бБ;\,<]],
   "юЮ;.>",
}
vim.o.langmap = table.concat(langmap_keys, ",")
vim.cmd([[set nocompatible]])

-- Folds ======================================================================
vim.o.foldmethod = "indent" -- Set 'indent' folding method
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 0        -- Display all folds except top ones
vim.o.foldnestmax = 10     -- Create folds only for some number of nested levels
vim.g.markdown_folding = 1 -- Use folding by heading in markdown files
-- vim.o.foldtext = "" -- Use underlying text with its highlighting
function _G.foldtext()
   local fs, fe = vim.v.foldstart, vim.v.foldend
   local start_line = vim.fn.getline(fs):gsub("\t", ("\t"):rep(vim.opt.ts:get()))
   local end_line = vim.trim(vim.fn.getline(fe))
   local spaces = (" "):rep(vim.o.columns - start_line:len() - end_line:len() - 7)

   return start_line .. "  " .. end_line .. spaces
end

vim.opt.foldtext = "v:lua.foldtext()"
vim.o.fillchars = table.concat({
   "fold: ",
   "eob: ",
   "horiz:═",
   "horizdown:╦",
   "horizup:╩",
   "vert:║",
   "verthoriz:╬",
   "vertleft:╣",
   "vertright:╠",
}, ",")

vim.env.FZF_DEFAULT_OPTS = "-i --margin=2 --reverse --cycle --layout=reverse"
local fzf_default_opts = vim.env.FZF_DEFAULT_OPTS or ""
local additional_opts =
"--bind=Tab:down,shift-Tab:up --color=bg+:-1 "
vim.env.FZF_DEFAULT_OPTS = fzf_default_opts .. " " .. additional_opts


if vim.g.neovide then
   vim.opt.linespace = 5
   vim.g.neovide_scale_factor = 1.0
   vim.g.neovide_cursor_trail_size = 0.1
   vim.g.neovide_scroll_animation_length = 0 -- disable animation of change buffers
   -- FIXME not sure what to pick - with/without padding
   vim.g.neovide_padding_top = 40
   vim.g.neovide_padding_bottom = 40
   vim.g.neovide_padding_right = 40
   vim.g.neovide_padding_left = 40

   vim.g.neovide_cursor_animation_length = 0.13
   vim.api.nvim_set_keymap(
      "n",
      "<C-=>",
      ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  2.0)<CR>",
      { silent = true }
   )
   vim.api.nvim_set_keymap(
      "n",
      "<C-->",
      ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>",
      { silent = true }
   )
   vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
   vim.cmd("cd")
   -- vim.g.clipboard = {
   -- 	name = "win32yank-wsl",
   -- 	copy = {
   -- 		["+"] = "win32yank.exe -i --crlf",
   -- 		["*"] = "win32yank.exe -i --crlf",
   -- 	},
   -- 	paste = {
   -- 		["+"] = "win32yank.exe -o --lf",
   -- 		["*"] = "win32yank.exe -o --lf",
   -- 	},
   -- 	cache_enabled = 0,
   -- }

   vim.g.neovide_theme = "default"
   vim.g.neovide_hide_mouse_when_typing = true
   vim.g.neovide_underline_stroke_scale = 0.9
   vim.g.neovide_no_custom_clipboard = true
   vim.g.neovide_refresh_rate = 60

   vim.g.neovide_confirm_quit = true
   vim.keymap.set("v", "<C-c>", "y")       -- Copy
   vim.keymap.set("n", "<C-v>", "P")       -- Paste normal mode
   vim.keymap.set("v", "<C-v>", "P")       -- Paste visual mode
   vim.keymap.set("c", "<C-v>", "<C-R>+")  -- Paste command mode
   vim.keymap.set("i", "<C-v>", "<ESC>pa") -- Paste insert mode

   vim.g.neovide_cursor_antialiasing = true
   vim.g.neovide_remember_window_size = true
   vim.g.remember_window_position = true

   vim.o.switchbuf = "newtab"
   -- impletemt somehow function to disable transparency for neovide buffers
   -- function Trans()
   -- 	vim.cmd("TransparentDisable")
   -- end
   -- vim.api.nvim_exec(
   -- 	[[
   --            autocmd BufEnter * silent lua vim.defer_fn(function() Trans() end, 103)
   --        ]],
   -- 	false
   -- )
end

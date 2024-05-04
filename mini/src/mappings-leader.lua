-- stylua: ignore start

-- Create global tables with information about clue groups in certain modes
-- Structure of tables is taken to be compatible with 'mini.clue'.
_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'n', keys = '<Leader>L', desc = '+Lua' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>r', desc = '+R' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal/Minitest' },
  { mode = 'n', keys = '<Leader>T', desc = '+Test' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },

  { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'x', keys = '<Leader>r', desc = '+R' },
}

-- Create `<Leader>` mappings
local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end

-- b is for 'buffer'
nmap_leader('ba', '<Cmd>b#<CR>',                                 'Alternate')
nmap_leader('x', '<Cmd>lua MiniBufremove.delete()<CR>',         'Delete')
nmap_leader('X', '<Cmd>lua MiniBufremove.delete(0, true)<CR>',  'Delete!')
nmap_leader('bs', '<Cmd>lua Config.new_scratch_buffer()<CR>',    'Scratch')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- e is for 'explore' and 'edit'
nmap_leader('ec', '<Cmd>lua MiniFiles.open(vim.fn.stdpath("config"))<CR>',                                  'Config')
nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>',                                                          'Directory')
nmap_leader('ef', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>',                              'File directory')
nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>',                                                                 'File directory')
nmap_leader('em', '<Cmd>lua MiniFiles.open(vim.fn.stdpath("data").."/site/pack/deps/start/mini.nvim")<CR>', 'Mini.nvim directory')
nmap_leader('ep', '<Cmd>lua MiniFiles.open(vim.fn.stdpath("data").."/site/pack/deps/opt")<CR>',             'Plugins directory')
nmap_leader('eq', '<Cmd>lua Config.toggle_quickfix()<CR>',                                                  'Quickfix')

-- g is for git
-- nmap_leader('gA', '<Cmd>lua require("gitsigns").stage_buffer()<CR>',        'Add buffer')
-- nmap_leader('ga', '<Cmd>lua require("gitsigns").stage_hunk()<CR>',          'Add (stage) hunk')
nmap_leader('gb', '<Cmd>lua require("gitsigns").blame_line()<CR>',          'Blame line')
nmap_leader('lg', '<Cmd>Lazygit<CR>',                     'Git tab')
nmap_leader('gp', '<Cmd>lua require("gitsigns").preview_hunk_inline()<CR>', 'Preview hunk')
nmap_leader('gq', '<Cmd>lua require("gitsigns").setqflist()<CR>:copen<CR>', 'Quickfix hunks')
-- nmap_leader('gu', '<Cmd>lua require("gitsigns").undo_stage_hunk()<CR>',     'Undo stage hunk')
-- nmap_leader('gx', '<Cmd>lua require("gitsigns").reset_hunk()<CR>',          'Discard (reset) hunk')
-- nmap_leader('gX', '<Cmd>lua require("gitsigns").reset_buffer()<CR>',        'Discard (reset) buffer')

-- l is for 'LSP' (Language Server Protocol)
nmap_leader('la', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Arguments popup')
nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>',  'Diagnostics popup')
nmap_leader('li', '<Cmd>lua vim.lsp.buf.hover()<CR>',          'Information')
nmap_leader('lj', '<Cmd>lua vim.diagnostic.goto_next()<CR>',   'Next diagnostic')
nmap_leader('lk', '<Cmd>lua vim.diagnostic.goto_prev()<CR>',   'Prev diagnostic')
nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>',     'References')
nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>',         'Rename')
nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>',     'Source definition')


-- L is for 'Lua'
nmap_leader('Lc', '<Cmd>lua Config.log_clear()<CR>',               'Clear log')
nmap_leader('LL', '<Cmd>luafile %<CR><Cmd>echo "Sourced lua"<CR>', 'Source buffer')
nmap_leader('Ls', '<Cmd>lua Config.log_print()<CR>',               'Show log')
nmap_leader('Lx', '<Cmd>lua Config.execute_lua_line()<CR>',        'Execute `lua` line')


-- o is for 'other' rewrite from o to other command
-- local trailspace_toggle_command = '<Cmd>lua vim.b.minitrailspace_disable = not vim.b.minitrailspace_disable<CR>'
-- nmap_leader('oh', '<Cmd>normal gxiagxila<CR>',             'Move arg left')
-- nmap_leader('oH', '<Cmd>TSBufToggle highlight<CR>',        'Highlight toggle')
-- nmap_leader('ol', '<Cmd>normal gxiagxina<CR>',             'Move arg right')
-- nmap_leader('or', '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
-- nmap_leader('os', '<Cmd>lua MiniSessions.select()<CR>',    'Session select')
-- nmap_leader('oS', '<Cmd>lua Config.insert_section()<CR>',  'Section insert')
-- nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>',    'Trim trailspace')
-- nmap_leader('oT', trailspace_toggle_command,                 'Trailspace hl toggle')
-- nmap_leader('oz', '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')



-- - In simple visual mode send text and move to the last character in
--   selection and move to the right. Otherwise (like in line or block visual
--   mode) send text and move one line down from bottom of selection.
local send_selection_cmd = [[mode() ==# "v" ? ":TREPLSendSelection<CR>`>l" : ":TREPLSendSelection<CR>'>j"]]
xmap_leader('s', send_selection_cmd, 'Send to terminal', { expr = true })


-- T is for 'test'
nmap_leader('TF', '<Cmd>TestFile -strategy=make | copen<CR>',    'File (quickfix)')
nmap_leader('Tf', '<Cmd>TestFile<CR>',                           'File')
nmap_leader('TL', '<Cmd>TestLast -strategy=make | copen<CR>',    'Last (quickfix)')
nmap_leader('Tl', '<Cmd>TestLast<CR>',                           'Last')
nmap_leader('TN', '<Cmd>TestNearest -strategy=make | copen<CR>', 'Nearest (quickfix)')
nmap_leader('Tn', '<Cmd>TestNearest<CR>',                        'Nearest')
nmap_leader('TS', '<Cmd>TestSuite -strategy=make | copen<CR>',   'Suite (quickfix)')
nmap_leader('Ts', '<Cmd>TestSuite<CR>',                          'Suite')

-- v is for 'visits'
nmap_leader('vv', '<Cmd>lua MiniVisits.add_label("core")<CR>',    'Add "core" label')
nmap_leader('vV', '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
nmap_leader('vl', '<Cmd>lua MiniVisits.add_label()<CR>',          'Add label')
nmap_leader('vL', '<Cmd>lua MiniVisits.remove_label()<CR>',       'Remove label')

local map_pick_core = function(keys, cwd, desc)
  local rhs = function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    MiniExtra.pickers.visit_paths({ cwd = cwd, filter = 'core', sort = sort_latest }, { source = { name = desc } })
  end
  nmap_leader(keys, rhs, desc)
end
map_pick_core('vc', '', 'Core visits (all)')
map_pick_core('vC', nil, 'Core visits (cwd)')
-- stylua: ignore end

vim.cmd([[
      command! -bang -nargs=* BLines
      \ call fzf#vim#grep(
      \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
      \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:50%', 'ctrl-l'))     " \   fzf#vim#with_preview({'options': '--layout reverse  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))
    ]])
-- Map keybindings
vim.api.nvim_set_keymap("n", "<M-d>", ":Files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-o>", ":History<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ff", ":Files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fw", ":RG<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":Buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o", ":History<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>/", ":BLines<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>L", ":Lines<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>'", ":Marks<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", ":AgRaw<space>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>H", ":Helptags!<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>c", ":Commands<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>:", ":History:<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>/", ":History/<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":Maps<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>s", ":Filetypes<CR>", { noremap = true, silent = true })

-- Search hidden
vim.cmd([[
  command! -bang -nargs=? -complete=dir AllFiles call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))
]])

vim.api.nvim_set_keymap("n", "<leader>F", ":AllFiles <CR>", { noremap = true, silent = true })

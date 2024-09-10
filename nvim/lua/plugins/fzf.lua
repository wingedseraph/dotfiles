return {
	{
		"ibhagwan/fzf-lua",
		-- lazy = false,
		event = vl,
		config = function()
			vim.api.nvim_set_keymap("n", "<M-d>", "<cmd>FzfLua files<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<M-o>", "<cmd>FzfLua oldfiles<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>FzfLua oldfiles<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>fn",
				"<cmd>lua require('fzf-lua').files({ cwd = '$HOME/notes/' })<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>/", "<cmd>FzfLua lgrep_curbuf<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"<leader>rg",
				"<cmd>FzfLua lgrep_curbuf<CR>",
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap("n", "<leader>L", "<cmd>FzfLua lines<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>'", "<cmd>FzfLua marks<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>H", "<cmd>FzfLua help_tags<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>k", "<cmd>FzfLua keymaps<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>fz", "<cmd>FzfLua builtin<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "<leader>fs", "<cmd>FzfLua lsp_finder<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap(
				"n",
				"<m-s>",
				"<cmd>:lua require'fzf-lua'.lsp_document_symbols({ winopts = { height=0.53, width=0.53 } })<cr>",
				{ noremap = true, silent = true }
			)

			vim.api.nvim_set_keymap(
				"n",
				"<leader>ds",
				-- "<cmd>FzfLua lsp_document_symbols<cr>",
				"<cmd>:lua require'fzf-lua'.lsp_document_symbols({ winopts = { height=0.83, width=0.83 } })<cr>",
				{ noremap = true, silent = true }
			)

			require("fzf-lua").setup({
				winopts = {
					width = 1,
					height = 1,
					border = "none",
					-- @windows usage
					-- preview = { hidden = "hidden" },
				},
			})
		end,
	},
}

return {
	{
		"lewis6991/gitsigns.nvim",
		event = vl,

		opts = {
			-- signs = {
			--    add = { text = '█' },
			--    change = { text = '█' },
			--    delete = { text = '█' },
			--    topdelete = { text = '█' },
			--    changedelete = { text = '█' },
			-- },
		},
	},
	{
		"tpope/vim-fugitive",
		-- event = vl,
		cmd = { "Git", "G" },
	},
}

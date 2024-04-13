return {
	"folke/noice.nvim",
	-- lazy = false,
	event = "BufEnter",
	config = function()
		vim.opt.showmode = false

		require("noice").setup({
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
			views = {
				cmdline_popup = {
					border = {
						style = "single",
						padding = { 0, 0 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				progress = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
				message = {
					enabled = false,
				},
				documentation = {
					enabled = false,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}

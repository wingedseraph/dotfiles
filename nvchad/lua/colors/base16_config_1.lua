return {
	require("mini.base16").setup({
		palette = require("mini.base16").mini_palette("#000000", "#bbbbbb", 10),
		use_cterm = nil,
		plugins = {
			default = true,
		},
	}),
}

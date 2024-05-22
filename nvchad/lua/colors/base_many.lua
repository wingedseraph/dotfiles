return {
	require("mini.base16").setup({
		palette = require("colors." .. Theme),
		cterm = true,
	}),
}

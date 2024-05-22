-- local null_ls = require("null-ls")
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- local b = null_ls.builtins
--
-- local sources = {
--
-- 	-- webdev stuff
-- 	-- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
-- 	-- b.formatting.cbfmt.with({ filetypes = { "markdown" } }),
-- 	-- b.formatting.htmlbeautifier.with({ filetypes = { "html" } }), -- for no warnings in w3 validator
--
-- 	b.diagnostics.eslint_d.with({ filetype = { "javascript" } }),
--
-- 	-- NOTE: turn off all formatting to test conform
--
-- 	-- Lua
-- 	-- b.formatting.stylua,
-- 	-- Python
-- 	-- b.formatting.autopep8.with({ filetypes = { "python" } }),
-- 	-- cpp
-- 	-- b.formatting.clang_format.with({ filetypes = { "c" } }),
-- 	-- b.formatting.gofmt.with({ filetypes = { "go" } }),
-- 	-- html css javascript
-- 	-- b.formatting.prettierd.with({ filetypes = { "html", "css", "javascript" } }), -- so prettier works only on these filetypes
-- 	b.diagnostics.eslint_d.with({ filetype = { "javascript" } }),
-- 	-- b.diagnostics.eslint_d.with({ filetype = { "javascript" } }),
-- }
--
-- null_ls.setup({
-- 	debug = false,
-- 	sources = sources,
-- 	on_attach = function(client, bufnr)
-- 		if client.supports_method("textDocument/formatting") then
-- 			vim.api.nvim_clear_autocmds({
-- 				group = augroup,
-- 				buffer = bufnr,
-- 			})
-- 			vim.api.nvim_create_autocmd("BufWritePre", {
-- 				group = augroup,
-- 				buffer = bufnr,
-- 				callback = function()
-- 					vim.lsp.buf.format({ async = true })
-- 				end,
-- 			})
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()
	end,
})
JS_linters = {}
if vim.fn.filereadable("./node_modules/.bin/biome") == 1 then
	table.insert(JS_linters, "biomejs")
else
	table.insert(JS_linters, "eslint_d")
end
require("lint").linters_by_ft = {
	html = { "htmlhint" },
	javascript = JS_linters,
	javascriptreact = JS_linters,
	typescript = JS_linters,
	typescriptreact = JS_linters,
}

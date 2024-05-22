-- local null_ls = require("null-ls")
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- local b = null_ls.builtins
--
-- local sources = {
-- b.formatting.biome.with({ filetype = { "javascript" } }),
-- b.diagnostics.eslint_d.with({ filetype = { "javascript" } }),
-- }

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
JS_linters = {}
if vim.fn.filereadable("./node_modules/.bin/biome") == 1 then
	table.insert(JS_linters, "biomejs")
else
	table.insert(JS_linters, "eslint_d")
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()
	end,
})
require("lint").linters_by_ft = {
	html = { "htmlhint" },
	javascript = JS_linters,
	javascriptreact = JS_linters,
	typescript = JS_linters,
	typescriptreact = JS_linters,
}

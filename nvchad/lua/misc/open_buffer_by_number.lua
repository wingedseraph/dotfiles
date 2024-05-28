-- Function to list all buffer IDs and their filenames, excluding empty and preview buffers
function list_buffers()
	local buffers = vim.api.nvim_list_bufs()
	local buffer_list = {}

	for _, buf in ipairs(buffers) do
		-- Check if the buffer is valid and listed (not hidden)
		if vim.api.nvim_buf_is_valid(buf) and vim.fn.buflisted(buf) == 1 then
			local buf_name = vim.api.nvim_buf_get_name(buf)
			local is_preview = vim.fn.getbufvar(buf, "&previewwindow") == 1

			-- Exclude empty buffers and the current buffer
			if buf_name ~= "" and not is_preview then
				table.insert(buffer_list, { id = buf, name = buf_name })
			end
		end
	end

	-- Sort buffers by their ID
	table.sort(buffer_list, function(a, b)
		return a.id < b.id
	end)

	return buffer_list
end

-- Function to open buffer by assigned number (1-9)
function open_buffer_by_number(number)
	local buffers = list_buffers()

	if number >= 1 and number <= #buffers then
		vim.api.nvim_set_current_buf(buffers[number].id)
	else
		print("Invalid buffer number: " .. number)
	end
end

-- Map leader key bindings to open buffers conditionally
-- for i = 1, 9 do
-- 	vim.api.nvim_set_keymap(
-- 		"n",
-- 		"<leader>" .. i,
-- 		":lua open_buffer_by_number(" .. i .. ")<CR>",
-- 		{ noremap = true, silent = true }
-- 	)
-- end

vim.keymap.set("n", "<M-1>", ":lua open_buffer_by_number(1)<cr>", { silent = true })
vim.keymap.set("n", "<M-2>", ":lua open_buffer_by_number(2)<cr>", { silent = true })
vim.keymap.set("n", "<M-3>", ":lua open_buffer_by_number(3)<cr>", { silent = true })
vim.keymap.set("n", "<M-4>", ":lua open_buffer_by_number(4)<cr>", { silent = true })
vim.keymap.set("n", "<M-5>", ":lua open_buffer_by_number(5)<cr>", { silent = true })
vim.keymap.set("n", "<M-6>", ":lua open_buffer_by_number(6)<cr>", { silent = true })
vim.keymap.set("n", "<M-7>", ":lua open_buffer_by_number(7)<cr>", { silent = true })
vim.keymap.set("n", "<M-8>", ":lua open_buffer_by_number(8)<cr>", { silent = true })
vim.keymap.set("n", "<M-9>", ":lua open_buffer_by_number(9)<cr>", { silent = true })

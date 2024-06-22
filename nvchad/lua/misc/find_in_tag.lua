function find_next_tag()
	local next_pos = vim.fn.searchpos("<[^>]*>[^<]*</[^>]*>", "W")

	if next_pos[1] > 0 then
		local line = vim.fn.getline(next_pos[1])
		if line then
			local tag_content = line:match("<[^>]*>([^<]*)</[^>]*>")
			if tag_content and #tag_content > 0 then
				local start_col = line:find(">", 1, true)
				vim.api.nvim_win_set_cursor(0, { next_pos[1], start_col })
			else
				-- If no content, move cursor right after the opening tag
				local start_col = line:find(">", 1, true)
				vim.api.nvim_win_set_cursor(0, { next_pos[1], start_col })
			end
		end
	else
		print("No next tags found")
	end
end
vim.api.nvim_set_keymap("n", "]t", ":lua find_next_tag()<CR>", { noremap = true, silent = true })

-- Function to find the previous HTML tag pattern in the buffer
function find_previous_tag()
	return vim.fn.searchpos("<[^>]*>[^<]*</[^>]*>", "bW")
end

-- Function to search in previous lines and place the cursor inside HTML tags
function place_cursor_inside_previous_tag()
	-- Search backward for the previous tag pattern
	find_previous_tag()
	local previous_pos = find_previous_tag()

	-- If a tag is found, move the cursor inside the tag content
	if previous_pos[1] > 0 then
		local line = vim.fn.getline(previous_pos[1])

		-- Ensure 'line' is not nil
		if line then
			local tag_content = line:match("<[^>]*>([^<]*)</[^>]*>")

			-- Check if there is content inside the tag
			if tag_content and #tag_content > 0 then
				local start_col = line:find(">", 1, true)
				vim.api.nvim_win_set_cursor(0, { previous_pos[1], start_col })
			else
				-- If no content, move cursor right after the opening tag
				local start_col = line:find(">", 1, true)
				vim.api.nvim_win_set_cursor(0, { previous_pos[1], start_col })
			end
		else
			print("Error: Unable to retrieve line")
		end
	else
		print("No previous tags found")
	end
end
vim.api.nvim_set_keymap("n", "[t", ":lua place_cursor_inside_previous_tag()<CR>", { noremap = true, silent = true })

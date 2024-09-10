-- init.lua
local time_tracker = require('time_tracker')

-- Start the time tracker when entering a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
   callback = function()
      time_tracker.start()
   end
})

-- Stop the time tracker when leaving a buffer
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
   callback = function()
      time_tracker.stop()
   end
})

-- Reset the time tracker when closing a buffer
vim.api.nvim_create_autocmd("BufDelete", {
   callback = function()
      time_tracker.reset()
   end
})

-- Command to print the current tracked time
vim.api.nvim_create_user_command('ShowTime', function()
   print("Time spent in current session: " .. time_tracker.get_time())
end, {})

return {
   {
      "levouh/tint.nvim",
      event = vl,
      opts = {
         tint = -75,       -- Darken colors, use a positive value to brighten
         saturation = 0.2, -- Saturation to preserve
         window_ignore_function = function(winid)
            local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
            return floating
         end,
         highlight_ignore_patterns = { "WinSeparator", "Status.*" },
      },
   },
   {
      "mrjones2014/smart-splits.nvim",
      event = vl,
      config = function()
         vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
         vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
         vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
         vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)
         vim.keymap.set("n", "<A-c>", "<C-w>c")

         vim.keymap.set("n", "<C-h>", require("smart-splits").resize_left)
         vim.keymap.set("n", "<C-j>", require("smart-splits").resize_down)
         vim.keymap.set("n", "<C-k>", require("smart-splits").resize_up)
         vim.keymap.set("n", "<C-l>", require("smart-splits").resize_right)
      end,
   },
}

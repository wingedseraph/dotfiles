return {
   {
      "lukas-reineke/indent-blankline.nvim",
      event = vl,
      version = "2.20.7",
      config = function()
         require("indent_blankline").setup({
            filetype_exclude = {
               "help",
               "terminal",
               "lazy",
               "lspinfo",
               "TelescopePrompt",
               "TelescopeResults",
               "mason",
               "nvdash",
               "nvcheatsheet",
               "",
            },
            buftype_exclude = { "terminal", "nofile" },
            show_first_indent_level = false,
            show_current_context = true,
            show_current_context_start_on_current_line = false,
            show_current_context_start = true,
            use_treesitter = true,
            char = "",
            -- char = "╎",
            -- context_char = "",
         })
         vim.cmd.hi('clear IndentBlanklineContextStart')
         vim.cmd.hi('link IndentBlanklineContextStart Visual')
      end
   },
}

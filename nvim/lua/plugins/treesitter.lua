return {
   {
      "nvim-treesitter/nvim-treesitter",
      -- build = ":TSUpdate",
      event = vl,

      config = function()
         require("nvim-treesitter.configs").setup({
            auto_install = true,
            ensure_installed = {
               "lua",
               "vim",
               "html",
               "css",
               "comment",
               "vimdoc",
               "javascript",
               "typescript",
               "tsx",
            },
            highlight = {
               enable = true,

               -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
               -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
               -- the name of the parser)
               -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
               disable = function(lang, buf)
                  local max_filesize = 100 * 1024 -- 100 KB
                  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                  if ok and stats and stats.size > max_filesize then
                     return true
                  end
               end,

               -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
               -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
               -- Using this option may slow down your editor, and you may see some duplicate highlights.
               -- Instead of true it can also be a list of languages
               additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
         })
      end,
   },
   { "nvim-treesitter/nvim-treesitter-context", opts = {}, event = vl },
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      event = vl,

      config = function()
         require("nvim-treesitter.configs").setup({
            textobjects = {
               select = {
                  enable = true,
                  lookahead = true,
                  keymaps = {
                     ["af"] = "@function.outer",
                     ["if"] = "@function.inner",
                     ["ac"] = "@class.outer",
                     ["ic"] = "@class.inner",
                  },
               },
            },
         })
      end,
   },
}

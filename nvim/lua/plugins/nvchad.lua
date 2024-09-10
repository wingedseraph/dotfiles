return {
   {
      enabled = vim.g.boot_nvchad and true or false,
      'NvChad/base46',
      lazy = false,
      build = function()
         require("base46").load_all_highlights()
      end,
   },
   {
      enabled = vim.g.boot_nvchad and true or false,
      'NvChad/ui',
      dependencies = "nvim-lua/plenary.nvim",
      lazy = false,
      config = function()
         require "nvchad"
         vim.g.base46_cache = vim.fn.stdpath('data') .. '/base46_cache/'
         dofile(vim.g.base46_cache .. "defaults")
         dofile(vim.g.base46_cache .. "statusline")
         for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
            dofile(vim.g.base46_cache .. v)
         end

         vim.defer_fn(function()
         end, 1)
         local function set_statusline_hi_to_normal()
            -- local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
            -- local normal_bg = normal_hl and normal_hl.bg or 'NONE'
            local normal_bg = '#1e1e1e'
            -- if normal_bg then
            --    normal_bg = string.format('#%06x', normal_bg)
            -- else
            --    normal_bg = 'NONE'
            -- end
            vim.api.nvim_set_hl(0, 'StatusLine', { bg = normal_bg })
            vim.api.nvim_set_hl(0, 'StatusLine', { fg = normal_bg })
            vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = normal_bg })
            vim.api.nvim_set_hl(0, 'TabLine', { bg = normal_bg })
            vim.api.nvim_set_hl(0, 'TabLine', { fg = normal_bg })
            vim.api.nvim_set_hl(0, 'TabLineFill', { bg = normal_bg })
            vim.api.nvim_set_hl(0, 'TabLineFill', { fg = normal_bg })
            vim.api.nvim_set_hl(0, 'TabLineSel', { fg = normal_bg })
            vim.o.showtabline = 2
            vim.opt.showmode = false
            function Set_winblend(component, value)
               vim.api.nvim_command('highlight ' .. component .. ' guibg=NONE blend=' .. value)
               Set_winblend('StatusLine', 10)
               Set_winblend('TabLine', 10)
            end
         end

         set_statusline_hi_to_normal()
         for i = 1, 9, 1 do
            vim.keymap.set("n", string.format("<A-%s>", i), function()
               if i <= #vim.t.bufs then
                  vim.api.nvim_set_current_buf(vim.t.bufs[i])
               else
                  print("Invalid buffer number: " .. i)
               end
            end)
         end
         vim.cmd.hi('clear @tag')
         vim.cmd.hi('link @tag Special')
      end,
      -- lazy = false,
      -- event = vl
   },
}

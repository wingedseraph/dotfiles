local util = require("nvim-base46.util")
local config = require("nvim-base46.config")
local highlights = require("nvim-base46.highlights")

local M = {}

---@type base46.Colors
M.colors = nil

---@type base46.HighlightsTable
M.highlight = util.highlight
theme = 'ashes'

-- @param opts string:
--   "aquarium", "ashes", "ayu_dark", "ayu_light", "bearded-arc", "blossom_light",
--   "catppuccin", "chadracula-evondev", "chadracula", "chadtain", "chocolate",
--   "dark_horizon", "decay", "doomchad", "everblush", "everforest", "everforest_light",
--   "falcon", "flex-light", "flexoki-light", "flexoki", "gatekeeper", "github_dark",
--   "github_light", "gruvbox", "gruvbox_light", "gruvchad", "jabuti", "jellybeans",
--   "kanagawa", "material-darker", "material-lighter", "melange", "mito-laser", "monekai",
--   "monochrome", "mountain", "nano-light", "nightfox", "nightlamp", "nightowl", "nord",
--   "oceanic-light", "oceanic-next", "one_light", "onedark", "onenord", "onenord_light",
--   "oxocarbon", "palenight", "pastelbeans", "pastelDark", "penumbra_dark", "penumbra_light",
--   "poimandres", "radium", "rosepine-dawn", "rosepine", "rxyhn", "solarized_dark",
--   "solarized_osaka", "sweetpastel", "tokyodark", "tokyonight", "tomorrow_night", "tundra",
--   "vscode_dark", "wombat", "yoru"
M.load = function(opts)
   if opts then
      theme = opts
   end

   -- local theme = config.options.theme
   -- theme = 'ashes'

   vim.o.termguicolors = true

   if vim.g.colors_name then
      vim.cmd("hi clear")
      vim.cmd("syntax reset")
   end

   vim.g.colors_name = string.format("base46-%s", theme)

   -- Update theme colors
   M.colors = require(string.format("nvim-base46.themes.%s", theme))

   -- Update base colors (used for util.darken and util.lighten)
   util.bg = M.colors.black
   util.fg = M.colors.white

   -- Highlight!
   highlights.setup(M.colors)

   if config.options.terminal_colors then
      highlights.setup_terminal(M.colors)
   end
end

---@param opts base46.Config
M.setup = function(opts)
   config.setup(opts)
end

return M

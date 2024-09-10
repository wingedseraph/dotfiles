-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

local M = {}

M.ui = {
   -- -@alias ThemeName
   ---| '"yoru"'
   ---| '"wombat"'
   ---| '"vscode_dark"'
   ---| '"tundra"'
   ---| '"tomorrow_night"'
   ---| '"tokyonight"'
   ---| '"tokyodark"'
   ---| '"sweetpastel"'
   ---| '"solarized_osaka"'
   ---| '"solarized_dark"'
   ---| '"rxyhn"'
   ---| '"rosepine"'
   ---| '"rosepine-dawn"'
   ---| '"radium"'
   ---| '"poimandres"'
   ---| '"penumbra_light"'
   ---| '"penumbra_dark"'
   ---| '"pastelbeans"'
   ---| '"pastelDark"'
   ---| '"palenight"'
   ---| '"oxocarbon"'
   ---| '"onenord_light"'
   ---| '"onenord"'
   ---| '"onedark"'
   ---| '"one_light"'
   ---| '"oceanic-next"'
   ---| '"oceanic-light"'
   ---| '"nord"'
   ---| '"nightowl"'
   ---| '"nightlamp"'
   ---| '"nightfox"'
   ---| '"nano-light"'
   ---| '"mountain"'
   ---| '"monochrome"'
   ---| '"monekai"'
   ---| '"mito-laser"'
   ---| '"melange"'
   ---| '"material-lighter"'
   ---| '"material-darker"'
   ---| '"kanagawa"'
   ---| '"jellybeans"'
   ---| '"jabuti"'
   ---| '"gruvchad"'
   ---| '"gruvbox_light"'
   ---| '"gruvbox"'
   ---| '"github_light"'
   ---| '"github_dark"'
   ---| '"gatekeeper"'
   ---| '"flexoki"'
   ---| '"flexoki-light"'
   ---| '"flex-light"'
   ---| '"falcon"'
   ---| '"everforest_light"'
   ---| '"everforest"'
   ---| '"everblush"'
   ---| '"doomchad"'
   ---| '"decay"'
   ---| '"dark_horizon"'
   ---| '"chocolate"'
   ---| '"chadtain"'
   ---| '"chadracula"'
   ---| '"chadracula-evondev"'
   ---| '"catppuccin"'
   ---| '"blossom_light"'
   ---| '"bearded-arc"'
   ---| '"ayu_light"'
   ---| '"ayu_dark"'
   ---| '"ashes"'
   ---| '"aquarium"'

   theme = "vscode_dark",

   hl_override = {
      Comment = { italic = true },
      ["@comment"] = { italic = true },
   },
}

return M

local context = vim.env.DOTFILES_CONTEXT or "local"

-- Same theme, different accent style per context
local style_map = {
  prod = "storm",   -- lighter bg makes prod feel distinct
  remote = "moon",  -- softer palette for remote
  local_ = "night", -- default dark aesthetic
}

local style = style_map[context] or style_map.local_

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = style,
      on_highlights = function(hl, c)
        if context == "prod" then
          -- Red cursor line and stronger visual cue
          hl.CursorLine = { bg = "#2d1520" }
          hl.StatusLine = { bg = c.red, fg = c.bg }
        end
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-" .. style,
    },
  },
}

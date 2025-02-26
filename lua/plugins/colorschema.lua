return {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = {
        custom_highlights = function(colors)
          return {
            NeoTreeGitIgnored = { fg = colors.subtext0 }, -- Make ignored files more visible
          }
        end,
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "catppuccin",
      },
    },
  }
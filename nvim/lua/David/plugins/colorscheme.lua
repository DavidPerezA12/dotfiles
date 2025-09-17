return {
  -- Nightfly colorscheme
  {
    "bluz71/vim-nightfly-guicolors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      -- set colorscheme to nightfly with protected call
      local status, _ = pcall(vim.cmd, "colorscheme nightfly")
      if not status then
        print("Colorscheme not found!")
        return
      end

      -- Configure transparent background
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    end,
  },

  -- Alternative colorschemes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
        lsp_saga = true,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}

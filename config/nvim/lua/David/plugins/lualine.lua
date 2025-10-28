return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")

      -- get lualine nightfly theme
      local lualine_nightfly = require("lualine.themes.nightfly")

      -- new colors for theme
      local new_colors = {
        blue = "#65D1FF",
        green = "#3EFFDC",
        violet = "#FF61EF",
        yellow = "#FFDA7B",
        black = "#000000",
      }

      -- change nightfly theme colors
      lualine_nightfly.normal.a.bg = new_colors.blue
      lualine_nightfly.insert.a.bg = new_colors.green
      lualine_nightfly.visual.a.bg = new_colors.violet
      lualine_nightfly.command = {
        a = {
          gui = "bold",
          bg = new_colors.yellow,
          fg = new_colors.black,
        },
      }

      -- configure lualine with modified theme
      lualine.setup({
        options = {
          theme = lualine_nightfly,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { "nvim-tree", "trouble" },
      })
    end,
  },
}

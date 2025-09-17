return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      comment.setup({
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })

      -- Reduce which-key overlap noise: prefer explicit toggles under <leader>/
      local api = require("Comment.api")
      vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, { desc = "Toggle comment line" })
      vim.keymap.set("v", "<leader>/", api.toggle.linewise(vim.fn.visualmode()), { desc = "Toggle comment selection" })
    end,
  },
}

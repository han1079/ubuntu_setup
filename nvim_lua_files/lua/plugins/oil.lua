return {
  "stevearc/oil.nvim",
  cmd = "Oil",             -- lazy-load on :Oil
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = true,   -- replaces netrw
    columns = { "icon" },
    view_options = {
      show_hidden = true,           -- show dotfiles
    },
    keymaps = {
      ["<C-h>"] = false,            -- unbind or override defaults if you want
    },
  },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
  },


}

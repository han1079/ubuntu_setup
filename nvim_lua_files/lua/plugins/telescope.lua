return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",                           -- lazy-load when :Telescope is used
  dependencies = { "nvim-lua/plenary.nvim", {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},
    "nvim-telescope/telescope-file-browser.nvim"},  -- required library
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
          },
        },
        preview = { hide_on_startup = false,}
      },
      pickers = {
        find_files = { theme = "dropdown", previewer = true, hidden = true},
        live_grep  = { theme = "ivy" },
      },
      extensions = {
                file_browser = {
                    theme = "dropdown",
                    hijack_netrw=true,
                },
                fzf={
                    fuzzy=true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
            },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
  end,
  keys = {
    { "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find File" },
    { "<leader>fg", "<CMD>Telescope live_grep<CR>",  desc = "Live Grep" },
    { "<leader>fb", "<CMD>Telescope buffers<CR>",    desc = "Find Buffer" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>",  desc = "Help Tags" },
    {
      "<leader>fe",
      function()
        require("telescope").extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = vim.fn.expand("%:p:h"),
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "insert",
        })
      end,
      desc = "Open file browser",
    },  
    },
}

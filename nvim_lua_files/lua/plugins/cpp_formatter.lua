
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})

      -- Smart indentation
      vim.opt.autoindent = true
      vim.opt.smartindent = true
      vim.opt.cindent = true

      vim.opt.formatoptions:append("o")

      -- Control C-like indentation behavior
      vim.opt.cinoptions = {
        "m1",  -- indent function braces one level
        "j1",  -- indent Java-style braces
        "l1",  -- align closing braces correctly
        "N-s", -- keep indentation level for new lines before a closing brace
      }    
      -- Auto insert closing brace with indent when pressing Enter after {
      vim.api.nvim_set_keymap(
        "i",
        "{<CR>",
        "{<CR>}<Esc>O",
        { noremap = true, silent = true }
      )
    end,
    ft = { "cpp", "c" }, -- only load for C/C++
  },
}

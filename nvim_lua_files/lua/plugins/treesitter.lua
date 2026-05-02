return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        ensure_installed = { "python", "c", "cpp", "lua", "javascript", "bash", "html" },
        highlight = { enable = true },
        indent    = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter").setup(opts)
    end,
}

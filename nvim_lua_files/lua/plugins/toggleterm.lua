return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { "<leader>tt", "<leader>ts" },
    config = function()
        require("toggleterm").setup({
            direction = "float",
            float_opts = {
                border = "single",
                width = function() return vim.o.columns end,
                height = 12,
                row = function() return vim.o.lines - 15 end,
                col = 0,
            },
        })
        vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
        vim.keymap.set("n", "<leader>ts", "<cmd>ToggleTermSendCurrentLine<CR>", { desc = "Send line to terminal" })
        vim.keymap.set("v", "<leader>ts", "<cmd>ToggleTermSendVisualSelection<CR>", { desc = "Send selection to terminal" })
    end,
}

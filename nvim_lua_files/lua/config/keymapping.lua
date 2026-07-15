-- lua/config/keymaps.lua
-- ======================

-- Set leader early (before anything else loads)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic file operations
-- Keeping it with normal keystrokes. I want to keep muscle memory for
-- non-kitted out vim instances.
--map("n", "<leader>w", ":w<CR>", opts)
--map("n", "<leader>q", ":q<CR>", opts)
--map("n", "<leader>x", ":x<CR>", opts)
--map("n", "<leader>Q", ":qa!<CR>", opts)


-- Buffers
map("n", "<leader>bl", ":bnext<CR>", opts)
map("n", "<leader>bh", ":bprev<CR>", opts)
map("n", "<leader>b<C-z>", ":b#<CR>", opts)
map("n", "<leader>bd", function()
    local target_buf = vim.api.nvim_get_current_buf()
    for _, win in ipairs(vim.fn.win_findbuf(target_buf)) do
        vim.api.nvim_win_call(win, function()
            local alt = vim.fn.bufnr("#")
            if alt > 0 and vim.fn.buflisted(alt) == 1 and alt ~= target_buf then
                vim.cmd("buffer #")
            else 
                vim.cmd("bnext")
            end

            if vim.api.nvim_get_current_buf() == target_buf then
                vim.cmd("enew")
            end
        end)
    end
    pcall(vim.api.nvim_buf_delete, target_buf, {})
end, opts)

-- Windows (splits)
map("n", "<leader>sv", ":vsplit<CR>", opts)
map("n", "<leader>sh", ":split<CR>", opts)

-- I want to retain SOME muscle memory of using C-w, since
-- it's not exactly common. Non-power vim may require this.

--map("n", "<leader>sc", "<C-w>c", opts)
--map("n", "<leader>so", "<C-w>o", opts)

-- This is pretty much mandatory imo - insane to go without
-- Move between splits with Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Tabs
map("n", "<leader>tn", ":tabnew<CR>", opts)
map("n", "<leader>tc", ":tabclose<CR>", opts)
map("n", "<leader>to", ":tabonly<CR>", opts)
map("n", "<leader>tl", ":tabnext<CR>", opts)
map("n", "<leader>th", ":tabprevious<CR>", opts)

-- Clear search highlights
-- Making this closer to Altium highlight clear
map("n", "<leader>C", ":nohlsearch<CR>", opts)

map("t", "<Esc>", "<C-\\><C-n>", opts)

-- Clipboard (Unix friendly)
map("v", "<leader>y", '"+y', opts)
map("n", "<leader>p", '"+p', opts)
map("n", "<leader>P", '"+P', opts)

-- LSP "Go-To"
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition"})
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration"})
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation"})
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references"})

-- Diagnostics
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostics" })

-- Dynamic Tab Sizing
vim.api.nvim_create_user_command("Tab", function(args)
    local n = tonumber(args.args)
    vim.o.tabstop = n
    vim.o.shiftwidth= n
    vim.o.expandtab = true 
end, { nargs = 1 , desc = "Set Tab Sizing for this session"}
)
vim.api.nvim_create_user_command("Messages", function() 
    vim.cmd("vnew | put =execute('messages')")
end, {desc = "Open :messages in a split"})

map("n", "<leader>err", ":Messages<CR>", opts)

-- Error Messages 

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
map("n", "<leader>bd", ":bd<CR>", opts)

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

-- Quick terminal (split)
map("n", "<leader>tt", ":split | terminal<CR>", opts)
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

-- Yazi --

--local yazi = require("util.yazi")
--vim.keymap.set("n", "<leader>fy", yazi.open, { desc = "Open Yazi file manager"})

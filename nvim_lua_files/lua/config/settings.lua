-- Basic Vim Settings. I want these in EVERY new vim that I set up.

vim.opt.number = true -- absolute line numbers
vim.opt.relativenumber = true -- the line I'm on gets relative numbers


-- Indentation
vim.opt.tabstop = 4            -- number of spaces tabs count for
vim.opt.shiftwidth = 4         -- spaces per indentation level
vim.opt.expandtab = true       -- convert tabs to spaces

vim.opt.cursorline = true 	-- highlights the current line.
vim.opt.scrolloff = 5		-- Scrolling starts, but with some buffer.
vim.opt.splitbelow = true
vim.opt.splitright = true	-- Defaults to splitting horiz. below and vert to the right

vim.opt.clipboard = "unnamedplus" -- VERY important. This means that y and p automatically go to clipboard.

vim.opt.swapfile = false -- swapfiles are annoying for weird close and open situation.
vim.opt.undofile = true -- keeps undo persistent.

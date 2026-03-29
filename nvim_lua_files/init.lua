require("config.settings")
require("config.keymapping")


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Load plugins (all plugin files under lua/plugins/)
require("lazy").setup("plugins", {
  ui = {
    border = "rounded",
  },
  change_detection = {
    notify = false,
  },
})

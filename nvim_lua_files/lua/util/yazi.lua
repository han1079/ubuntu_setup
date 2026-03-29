local M = {}

function M.open()
  local yazi_exe = vim.fn.exepath("yazi")
  if yazi_exe == "" then
    vim.notify("Yazi not found in PATH inside Neovim", vim.log.levels.ERROR)
    return
  end

  -- save the window you were in (optional; useful later)
  local target_win = vim.api.nvim_get_current_win()

  local buf = vim.api.nvim_create_buf(false, true)
  local W, H = math.floor(vim.o.columns*0.9), math.floor(vim.o.lines*0.9)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = W, height = H,
    row = math.floor((vim.o.lines - H)/2),
    col = math.floor((vim.o.columns - W)/2),
    style = "minimal",
    border = "rounded",
  })

  -- IMPORTANT: use `env NVIM=... yazi` so we *add* NVIM without clobbering PATH/SHELL
  vim.fn.termopen({ "env", "NVIM=" .. vim.v.servername, "NVIM_TARGET_WIN=" .. target_win, yazi_exe }, {
    on_exit = function(_, code)
      if code == 0 and vim.api.nvim_win_is_valid(win) then
        pcall(vim.api.nvim_win_close, win, true)
      end
    end,
  })

  vim.schedule(function() vim.cmd("startinsert") end)
end

return M

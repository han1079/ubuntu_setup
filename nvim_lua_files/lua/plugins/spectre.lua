return {
    "nvim-pack/nvim-spectre",
    lazy=false,
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        require("spectre").setup({
            color_devicons = true,
            mapping = {
                ['toggle_line'] = {
                    map = "dd",
                    cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                    desc = "toggle item"
                },
                ['enter_file'] = {
                    map = "<cr>",
                    cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                    desc = "open file"
                },
                ['send_to_qf'] = {
                    map = "<leader>q",
                    cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                    desc = "send all items to quickfix"
                },
                ['replace_cmd'] = {
                    map = "<leader>c",
                    cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                    desc = "input replace command"
                },
                ['show_option_menu'] = {
                    map = "<leader>o",
                    cmd = "<cmd>lua require('spectre').show_options()<CR>",
                    desc = "show options"
                },
                ['run_current_replace'] = {
                    map = "<leader>rc",
                    cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
                    desc = "replace current line"
                },
                ['run_replace'] = {
                    map = "<leader>R",
                    cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                    desc = "replace all"
                }
            },
            find_engine = {
                ['rg'] = {
                    cmd = "rg",
                    args = nil,
                    options = {}
                }
            },
            replace_engine = {
                ['sed'] = {
                    cmd = "sed",
                    args = nil
                }
            },
            default = {
                find    = { cmd = "rg",  options = {"ignore-case"} },
                replace = { cmd = "sed" }
            }
        })
        local map = vim.keymap.set
        map("n", "<leader>fs", "<cmd>lua require('spectre').open()<CR>",                          { desc = "Spectre: open" })
        map("n", "<leader>fw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { desc = "Spectre: search word under cursor" })
        map("v", "<leader>fw", "<esc><cmd>lua require('spectre').open_visual()<CR>",              { desc = "Spectre: search in visual selection" })
    end
}

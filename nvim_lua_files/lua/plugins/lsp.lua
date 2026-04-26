-- This file gets called by the upstream package manager and returns a list that includes
-- The name of the plugin (lspconfig)
-- Any sub-dependencies that this will require additional pulls for
-- The configuration that this plugin comes in
-- Given all of that, the package manager can then run the whole thing.
return{
	"neovim/nvim-lspconfig",
	event = {"BufReadPre", "BufNewFile"},

    dependencies = {
    {
      "williamboman/mason.nvim",
      version = "^2.0.0",     -- ensure v2+
      build = ":MasonUpdate", -- optional: keep registries fresh
      config = true,          -- runs require("mason").setup()
    },

    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
    },

    { "hrsh7th/cmp-nvim-lsp" },

    },
	config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local servers = { "lua_ls", "pyright", "clangd", "texlab" }
        vim.lsp.config.clangd = {
            capabilities = capabilities,
            cmd = {"clangd", "--query-driver=**", "--background-index"},
        }
        mason_lspconfig.setup({
            ensure_installed = servers,
            automatic_installation = true,
            
            handlers = {
                function(server_name)
                    vim.lsp.config[server_name] = {
                    capabilities = capabilities,
                    }
                    vim.lsp.enable(server_name)
                end,
                
                clangd = function()
                    vim.lsp.config.clangd = {
                        capabilities = capabilities,
                        cmd = {"clangd", "--compile-commands-dir=build"},
                    }
                    vim.lsp.enable("clangd")
                end,

                ["texlab"] = function()
                    vim.lsp.config.texlab = {
                        capabilities = capabilities,
                        settings = {
                            texlab = {
                                forwardSearch = {
                                    executable = "zathura",
                                    args = { "--synctex-forward", "%l:1:%f", "%p" },
                                },
                            },
                        },
                    }
                    vim.lsp.enable("texlab")
                end,
            }
        })
    end
}

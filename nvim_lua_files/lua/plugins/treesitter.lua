return{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = {"BufReadPost", "BufNewFile" },

	config = function()
		local treesitter_config_object = require("nvim-treesitter.configs")
		local languages_supported  = {
			"python",
			"c",
			"cpp",
			"lua",
			"javascript",
			"bash",
            "html",
		}

		treesitter_config_object.setup({
			ensure_installed = languages_supported,
			highlight = {enable = true},
			indent = {enable = true},
		})
	end,
}

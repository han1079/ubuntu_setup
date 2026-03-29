return	{
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
	 "hrsh7th/cmp-buffer" ,
	 "hrsh7th/cmp-path" ,
	 "hrsh7th/cmp-cmdline" ,
	 "hrsh7th/cmp-nvim-lsp" ,
 	 "L3MON4D3/LuaSnip",
	 "saadparwaiz1/cmp_luasnip",
 	},
	
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local function luasnip_expand_fcn(args)
			luasnip.lsp_expand(args.body)
		end

		local mysnip = {expand = luasnip_expand_fcn}
	
		local mymap = {
		    ["<Tab>"] = cmp.mapping.select_next_item(),
		    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
		    ["<CR>"] = cmp.mapping.confirm({ select = true }),
		}

		local mysources = {
			{ name = "luasnip"},
			{ name = "path"},
			{ name = "nvim_lsp"},
			{ name = "buffer"},
		}

		cmp.setup({
			snippet = mysnip,
			mapping = mymap,
			sources = mysources,
		})
	end
}

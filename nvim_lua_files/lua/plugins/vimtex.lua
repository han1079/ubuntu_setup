return{
	"lervag/vimtex",
	ft = {"tex"},
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_compiler_latexmk = {
			continuous = 1,
			executable = "latexmk",
			options = { "-pdf", "-interaction=nonstopmode", "-synctex=1" },
		}
	end,
}

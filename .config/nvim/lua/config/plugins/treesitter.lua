return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		opts = {
			ensure_installed = {
				"bash",
				"diff",
				"html",
				"javascript",
				"css",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"zig",
				"gdscript",
				"gdshader",
				"latex",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
  -- This is to show the context of the current code block at the top of the buffer (sticky)
	"nvim-treesitter/nvim-treesitter-context",
}

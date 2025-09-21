return {
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "<leader>hi", gitsigns.preview_hunk_inline)
					map("n", "<leader>hr", gitsigns.reset_hunk)
					map("n", "<leader>hd", gitsigns.diffthis)
					map("n", "<leader>lb", gitsigns.toggle_current_line_blame)
				end,
			})
		end,
	},
}

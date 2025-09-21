-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Toggle diagnostic keymaps (Show errors / warnings etc)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Vim souls-like
local hardmode = true
if hardmode then
	-- Disable arrow keys in insert mode
	vim.api.nvim_set_keymap("i", "<Up>", "<C-o>" .. [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("i", "<Down>", "<C-o>" .. [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("i", "<Left>", "<C-o>" .. [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("i", "<Right>", "<C-o>" .. [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("i", "<Del>", "<C-o>" .. [[]], { noremap = true, silent = false })
	-- vim.api.nvim_set_keymap('i', '<BS>', '<C-o>' .. [[]], { noremap = true, silent = false })

	-- Disable arrow keys in normal mode
	vim.api.nvim_set_keymap("n", "<Up>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("n", "<Down>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("n", "<Left>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("n", "<Right>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("n", "<BS>", [[]], { noremap = true, silent = false })

	-- Disable arrow keys in visual mode
	vim.api.nvim_set_keymap("v", "<Up>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("v", "<Down>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("v", "<Left>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("v", "<Right>", [[]], { noremap = true, silent = false })
	vim.api.nvim_set_keymap("v", "<BS>", [[]], { noremap = true, silent = false })
end

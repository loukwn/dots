-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Vim souls-like
local hardmode = true
if hardmode then
  -- Show an error message if a disabled key is pressed
  local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]
  -- Disable arrow keys in insert mode with a styled message
  vim.api.nvim_set_keymap('i', '<Up>', '<C-o>' .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('i', '<Down>', '<C-o>' .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('i', '<Left>', '<C-o>' .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('i', '<Right>', '<C-o>' .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('i', '<Del>', '<C-o>' .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap('i', '<BS>', '<C-o>' .. msg, { noremap = true, silent = false })

  -- Disable arrow keys in normal mode with a styled message
  vim.api.nvim_set_keymap('n', '<Up>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('n', '<Down>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('n', '<Left>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('n', '<Right>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('n', '<BS>', msg, { noremap = true, silent = false })

  -- Disable arrow keys in visual mode with a styled message
  vim.api.nvim_set_keymap('v', '<Up>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('v', '<Down>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('v', '<Left>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('v', '<Right>', msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap('v', '<BS>', msg, { noremap = true, silent = false })
end

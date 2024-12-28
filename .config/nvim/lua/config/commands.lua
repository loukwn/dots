-- Hijacks netrw in favor of telescope.find_files() when starting nvim on a directory
--  Clear FileExplorer appropriately to prevent netrw from launching on folders
--  Netrw may or may not be loaded before telescope-find-files
--  Conceptual credits to nvim-tree and telescope-file-browser
--  https://github.com/nvim-telescope/telescope.nvim/issues/2806#issuecomment-1904877188
local find_files_hijack_netrw = vim.api.nvim_create_augroup('find_files_hijack_netrw', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = '*',
  once = true,
  callback = function()
    pcall(vim.api.nvim_clear_autocmds, { group = 'FileExplorer' })
  end,
})
vim.api.nvim_create_autocmd('BufEnter', {
  group = find_files_hijack_netrw,
  pattern = '*',
  callback = function()
    vim.schedule(function()
      -- Early return if netrw or not a directory
      if vim.bo[0].filetype == 'netrw' or vim.fn.isdirectory(vim.fn.expand '%:p') == 0 then
        return
      end

      vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')

      require('telescope.builtin').find_files {
        cwd = vim.fn.expand '%:p:h',
      }
    end)
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

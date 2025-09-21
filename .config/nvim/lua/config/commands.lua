--
-- Hijacks netrw in favor of telescope.find_files() when starting nvim on a directory
--
local find_files_hijack_netrw = vim.api.nvim_create_augroup("find_files_hijack_netrw", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	once = true,
	callback = function()
		pcall(vim.api.nvim_clear_autocmds, { group = "FileExplorer" })
	end,
})
Netrw_override_enter_event = vim.api.nvim_create_autocmd("BufEnter", {
	group = find_files_hijack_netrw,
	pattern = "*",
	callback = function()
		vim.schedule(function()
			local dir = vim.fn.expand("%:p")
			local buf_ft = vim.bo[0].filetype

			-- Early return if netrw or not a directory
			if buf_ft == "netrw" or vim.fn.isdirectory(dir) == 0 then
				return
			end

			-- We are opening either netrw or telescope so this buffer can be wiped
			vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })

			-- If there is at least one file in the directory (or subdirectories) proceed with telescope
			-- Otherwise open netrw on empty directories
			local fs = vim.loop.fs_scandir(dir)
			local found_file = false
			if fs then
				while true do
					local name, t = vim.loop.fs_scandir_next(fs)
					if not name then
						break
					end
					if t == "file" then
						found_file = true
						break
					end
				end
			end

			if not found_file then
				vim.cmd("Explore " .. vim.fn.fnameescape(dir))
				return
			end

			-- Show telescope for that folder, with the ability to close nvim when nothing selected
			require("telescope.builtin").find_files({
				cwd = dir,
				attach_mappings = function(_, map)
					local actions = require("telescope.actions")

					local function quit_nvim(prompt_bufnr)
						actions.close(prompt_bufnr)
						vim.schedule(function()
							vim.cmd("quitall")
						end)
					end

					map("i", "<Esc>", quit_nvim)
					map("n", "q", quit_nvim)
					return true
				end,
			})

			-- Remove this autocmd so it does not fire over and over
			vim.api.nvim_del_autocmd(Netrw_override_enter_event)
		end)
	end,
})

--
-- Highlight when yanking (copying) text
--
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

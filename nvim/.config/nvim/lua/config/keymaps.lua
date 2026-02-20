-- Keymaps are automatically loaded on the VeryLazy event

-- jj to escape
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Copy path helpers
vim.keymap.set("n", "<leader>pr", "<cmd>CopyFileRelativePath<CR>", { desc = "Copy relative file path" })
vim.keymap.set("n", "<leader>pa", "<cmd>CopyFileAbsolutePath<CR>", { desc = "Copy absolute file path" })
vim.keymap.set("n", "<leader>pn", "<cmd>CopyFileName<CR>", { desc = "Copy file name" })

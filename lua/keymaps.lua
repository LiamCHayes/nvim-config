-- space bar leader key
vim.g.mapleader = " "

-- switch windows with leader
vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>', { noremap = true, silent = true, desc = "Window pane operations" })

-- switch between buffers with leader
vim.api.nvim_set_keymap('n', '<leader>n', ':bn<cr>', { noremap = true, silent = true, desc = "Next buffer" })
vim.api.nvim_set_keymap('n', '<leader>p', ':bp<cr>', { noremap = true, silent = true, desc = "Previous buffer" })
vim.api.nvim_set_keymap('n', '<leader>x', ':bd<cr>', { noremap = true, silent = true, desc = "Close buffer" })
vim.api.nvim_set_keymap('n', '<leader>l', ':b#<cr>', { noremap = true, silent = true, desc = "Last buffer" })

-- vertical split
vim.api.nvim_set_keymap('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true, desc = "Vertical split" })

-- save and quit
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', { noremap = true, silent = true, desc = "Quit" })

-- save
vim.api.nvim_set_keymap('n', '<leader>s', ':w<cr>', { noremap = true, silent = true, desc = "Save file" })

-- norm shortcut
vim.api.nvim_set_keymap('v', '<leader>n', ':norm ', { noremap = true, silent = true, desc = "Enter norm mode" })

-- find and replace
vim.api.nvim_set_keymap('n', '<leader>fr', ':%s/', { noremap = true, silent = true, desc = "Find and replace" })

-- open terminal in neovim
vim.api.nvim_set_keymap('n', '<leader>t', ':term<cr>', { noremap = true, silent = true, desc = "Open terminal" })

-- get diagnostics quick fix list
vim.api.nvim_set_keymap('n', '<leader>di', ':lua vim.diagnostic.setqflist()<cr>', { noremap = true, silent = true, desc = "Inspect diagnostics in quick fix list" })

-- Quickfix list shortcuts
vim.api.nvim_set_keymap('n', '<leader>cc', ':cclose<cr>', { noremap = true, silent = true, desc = "Close Quickfix list" })
vim.api.nvim_set_keymap('n', '<leader>co', ':copen<cr>', { noremap = true, silent = true, desc = "Open Quickfix list" })
vim.api.nvim_set_keymap('n', '<leader>cj', ':cnext<cr>', { noremap = true, silent = true, desc = "Next item in Quickfix list" })
vim.api.nvim_set_keymap('n', '<leader>ck', ':cprev<cr>', { noremap = true, silent = true, desc = "Previous item in Quickfix list" })
vim.api.nvim_set_keymap('n', '<leader>cn', ':cnewer<cr>', { noremap = true, silent = true, desc = "Next Quickfix list" })
vim.api.nvim_set_keymap('n', '<leader>cp', ':colder<cr>', { noremap = true, silent = true, desc = "Previous Quickfix list" })
vim.api.nvim_set_keymap('n', '<leader>cgg', ':cfirst<cr>', { noremap = true, silent = true, desc = "First item in Quickfix list" })
vim.api.nvim_set_keymap('n', '<leader>cG', ':clast<cr>', { noremap = true, silent = true, desc = "Last item in Quickfix list" })

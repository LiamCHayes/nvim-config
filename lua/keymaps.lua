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

-- telescope
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>", { desc = "Find files" })

-- file editor
vim.keymap.set("n", "<leader>e", function()
    if vim.bo.filetype == "oil" then
        -- If already in Oil, go back to the previous buffer
        vim.cmd("b#") 
    else
        -- Otherwise, open Oil for the current directory
        require("oil").open()
    end
end, { desc = "Toggle Oil buffer" })

-- undo tree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { desc = "Toggle Undotree" })

-- lazygit
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })

-- navigate terminals
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

-- open terminals
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>TermSelect<cr>', { noremap = true, silent = true, desc = "Open specific terminal" })
vim.api.nvim_set_keymap('n', '<leader>tn', '<cmd>ToggleTermSetName<cr>', { noremap = true, silent = true, desc = "Set terminal name" })
vim.api.nvim_set_keymap('n', '<leader>th', '<cmd>ToggleTerm size=15 direction=horizontal<cr>', { noremap = true, silent = true, desc = "Horizontal terminal" })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm size=60 direction=vertical<cr>', { noremap = true, silent = true, desc = "Vertical terminal" })
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { noremap = true, silent = true, desc = "Floating terminal" })

-- zen mode
vim.keymap.set("n", "<leader>z", ":ZenMode<cr>", { desc = "Toggle Zen mode" })

-- lsp
local lspconfig = require('lspconfig')

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({ async = true }) end, opts)
    end,
})

vim.api.nvim_set_keymap('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true, desc = "Show error message" })

-- LaTeX compile
vim.keymap.set("n", "<leader>Cl", ":w<cr> :VimtexCompile<cr>", { desc = "Compile LaTeX document" })

-- Typst compile
vim.keymap.set("n", "<leader>Ct", ":TypstPreview<cr> :TypstWatch<cr>", { desc = "Compile Typst document" })

--Code Companion (AI)
-- vim.keymap.set("n", "<leader>cc", ":CodeCompanionChat Toggle<cr>", { desc = "Toggle AI chat buffer" })


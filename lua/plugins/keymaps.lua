-- telescope
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>", { desc = "Grep files" })

-- file editor
vim.keymap.set("n", "<leader>e", ":Oil --float<cr>", { desc = "Toggle file tree" })

-- undo tree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>", { desc = "Toggle Undotree" })

-- lazygit
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })

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


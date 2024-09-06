return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set('n', '<leader>n', ':Neotree show filesystem toggle right<CR>')
        vim.keymap.set('n', '<leader>m', ':Neotree filesystem toggle float<CR>')

        require('neo-tree').setup({
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols",
            },
            source_selector = {
                winbar = true,
                statusline = false,
                sources = {
                    { source = 'filesystem' },
                    { source = 'buffers' },
                    { source = 'git_status' },
                    { source = 'document_symbols' },
                }
            },
        })
    end
}

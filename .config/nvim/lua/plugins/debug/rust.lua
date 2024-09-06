return {
    'mrcjkb/rustaceanvim',
    version = '^3', -- Recommended
    ft = { 'rust' },
    opts = {
        server = {
            on_attach = function(client, bufnr)
                require('which-key').register({
                    ['<leader>Dr'] = { name = '[R]ust Debuggables', _ = '<cmd>RustLsp debuggables<cr>' }
                }, { mode = 'n', buffer = bufnr })
            end,
            setting = {
                ['rust-analyzer'] = {

                },
            },
        },
    },
}

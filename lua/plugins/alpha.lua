return {
    'goolord/alpha-nvim',
    event = 'VimEnter',

    opts = function()
        local dashboard = require 'alpha.themes.dashboard'
        local logo = require 'dashboard-icons'

        dashboard.section.header.val = vim.split(logo, '\n')
        dashboard.section.buttons.val = {
            dashboard.button('n', '  New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('r', '  Recent files', ':Telescope oldfiles <CR>'),
            dashboard.button('f', '󰥨  Find file', ':Telescope find_files <CR>'),
            dashboard.button('g', '󰱼  Find text', ':Telescope live_grep <CR>'),
            dashboard.button('l', '󰒲  Lazy', ':Lazy<CR>'),
            dashboard.button('q', '  Quit', ':qa<CR>'),
        }
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = 'AlphaButtons'
            button.opts.hl_shortcut = 'AlphaShortcut'
        end
        dashboard.section.header.opts.hl = 'AlphaHeader'
        dashboard.section.buttons.opts.hl = 'AlphaButtons'
        dashboard.section.footer.opts.hl = 'AlphaFooter'

        dashboard.section.buttons.opts.spacing = 0
        table.insert(dashboard.config.layout, 5, { type = 'padding', val = 1 })

        return dashboard
    end,

    config = function(_, dashboard)
        -- close Lazy and reopens when the dashboard is ready
        if vim.o.filetype == 'Lazy' then
            vim.cmd.close()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'AlphaReady',
                callback = function()
                    require('lazy').show()
                end,
            })
        end

        require 'alpha'.setup(require 'alpha.themes.dashboard'.config)

        vim.api.nvim_create_autocmd('User', {
            pattern = 'LazyVimStarted',
            callback = function()
                local stats = require('lazy').stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = '⚡ ' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
                pcall(vim.cmd.AlphaRedraw)
            end
        })
    end
};

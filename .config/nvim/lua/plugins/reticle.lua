return {
    'tummetott/reticle.nvim',
    event = 'VeryLazy',
    config = function()
        local reticle = require('reticle')
        reticle.setup()
        reticle.set_cursorline(true)
    end
}

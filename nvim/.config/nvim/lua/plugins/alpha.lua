local function getLogoHeight(logo)
  local height = 0
  for _ in logo:gmatch("[^\r\n]+") do
    height = height + 1
  end
  return height
end

return {
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = require("dashboard-icons")

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("e", "󰈢  Explore files", ":Neotree filesystem toggle float<CR>"),
        dashboard.button("f", "󰥨  Find file", ":Telescope find_files <CR>"),
        dashboard.button("g", "󰱼  Find text", ":Telescope live_grep <CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      table.insert(dashboard.config.layout, 5, { type = "padding", val = 1 })
      dashboard.section.buttons.opts.spacing = 0
      if getLogoHeight(logo) > 25 then
        dashboard.opts.layout[1].val = 2
      end
      dashboard.opts.layout[3].val = 1

      return dashboard
    end,

    config = function(_, dashboard)
      -- close Lazy and reopens when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins loaded in "
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}

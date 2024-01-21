require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {
        'neo-tree',
        'alpha',
        'checkhealth',

        'dapui_watches',
        'dapui_stacks',
        'dapui_breakpoints',
        'dapui_scopes',
        'dapui_console',
        'dap-repl'
      },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      'branch',
      'diff',
      { 'diagnostics', },
    },
    lualine_c = { 'filename' },
    lualine_x = {
      'encoding',
      { 'fileformat', icons_enabled = false }
    },
    lualine_y = {
      {
        function()
          local lsps = vim.lsp.get_active_clients({ bufnr = vim.fn.bufnr() })
          local icon = require("nvim-web-devicons").get_icon_by_filetype(
            vim.api.nvim_buf_get_option(0, "filetype")
          )
          if lsps and #lsps > 0 then
            local names = {}
            for _, lsp in ipairs(lsps) do
              table.insert(names, lsp.name)
            end
            return string.format("%s %s", table.concat(names, ", "), icon)
          else
            return icon or ""
          end
        end,
        on_click = function()
          vim.api.nvim_command("LspInfo")
        end,
        color = function()
          local _, color = require("nvim-web-devicons").get_icon_cterm_color_by_filetype(
            vim.api.nvim_buf_get_option(0, "filetype")
          )
          return { fg = color }
        end,
      }
    },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    }
  },
  inactive_sections = {},
  tabline = {},
  winbar = {
    lualine_b = {
      { 'filetype', icon_only = true, separator = { left = '' } },
      { 'filename', separator = { right = '' } }
    },
  },
  inactive_winbar = {
    lualine_a = {
      { 'filetype', icon_only = true, separator = { left = '' } },
      { 'filename', separator = { right = '' } }
    },
  },
  extensions = { 'neo-tree' }
}

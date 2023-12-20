return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'simrat39/rust-tools.nvim'
  },
  config = function()
    require("neodev").setup()
    local lspconfig = require('lspconfig')

    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        silent = true,
        border = 'rounded',
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
    }

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }


    lspconfig.pyright.setup {
      capabilities = capabilities,
      handlers = handlers,
    }
    lspconfig.tailwindcss.setup {
      capabilities = capabilities,
      handlers = handlers,
    }
    lspconfig.tsserver.setup {
      capabilities = capabilities,
      handlers = handlers,
    }
    lspconfig.rust_analyzer.setup {
      capabilities = capabilities,
      handlers = handlers,
      settings = {
        ['rust-analyzer'] = {
          cachePriming = {
            enable = false
          },
          imports = {
            granularity = {
              group = "module",
            },
            prefix = "self",
          },
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          procMacro = {
            enable = true,
          },
        },
      }
    }

    vim.api.nvim_create_autocmd("CursorHoldI", {
      pattern = "*",
      callback = vim.lsp.buf.signature_help
    })

  end
}

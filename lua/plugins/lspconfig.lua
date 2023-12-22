return {
  'neovim/nvim-lspconfig',
  event = {'BufReadPre', 'BufNewFile'},
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    {'williamboman/mason.nvim', cmd = 'Mason', build = ':MasonUpdate'},
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
    'simrat39/rust-tools.nvim'
  },
  opts = {
        servers = {
          tsserver = {
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "literal",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = false,
                  includeInlayVariableTypeHints = false,
                  includeInlayPropertyDeclarationTypeHints = false,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          },
          lua_ls = {
            settings = { Lua = { diagnostics = { globals = { "vim" } } } },
          },
          tailwindcss = {
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  },
                },
              },
            },
          },
          rust_analyzer = {
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
        },
      },
  config = function(_, opts)
    require("neodev").setup()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = {"rust_analyzer", "tsserver", "pyright", "tailwindcss", "lua_ls", "eslint", "cssls"}
    }
    local lsp_capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

    require("mason-lspconfig").setup_handlers({
      function (server_name)
        require('lspconfig')[server_name].setup {
          capabilities = lsp_capabilities,
          settings = opts.servers[server_name] and opts.servers[server_name].settings or {}
        }
      end
    })
    vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
        },
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
  end
}

function kmap(mode, key, val, desc, opts)
  local opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, key, val, opts)
end


-- noh
kmap('n', '<esc>', ':noh<CR>', 'Remove highlight')

-- save & close
kmap('n', '<M-s>', ":w<CR>", 'Save current buffer')
kmap('n', '<M-q>', ":q<CR>", 'Close current buffer')

-- splits
kmap('n', '<M-h>', ":vne<CR>", 'Open a new window to the right')
kmap('n', '<M-v>', ":new<CR>", 'Open a new window below')

kmap('n', '<C-Up>', '<C-w>k', 'Go to the window above')
kmap('n', '<C-Down>', '<C-w>j', 'Go to the window below')
kmap('n', '<C-Left>', '<C-w>h', 'Go to the window on the left')
kmap('n', '<C-Right>', '<C-w>l', 'Go to the window on the right')

kmap('n', '<C-M-Up>', ':res +2<CR>', 'Increase window verical size')
kmap('n', '<C-M-Down>', ':res -2<CR>', 'Decrease window verical size')
kmap('n', '<C-M-Left>', ':vert res -5<CR>', 'Decrease window horizontal size')
kmap('n', '<C-M-Right>', ':vert res +5<CR>', 'Increase window horizontal size')


-- tabs
kmap('n', '<M-t>', ":tabnew<CR>", 'Open a new tab')
kmap('n', '<M-Left>', ":tabprevious<CR>", 'Go to previous tab')
kmap('n', '<M-Right>', ":tabnext<CR>", 'Go to next tab')

-- term
kmap('t', '<esc>', '<C-\\><C-n>', 'Leave terminal mode')


-- LSP
kmap('n', '<space>e', vim.diagnostic.open_float, 'Open the diagnostic float window')
kmap('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
kmap('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
kmap('n', '<space>q', vim.diagnostic.setloclist, 'Something about diags')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    kmap('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration', opts)
    kmap('n', 'gd', vim.lsp.buf.definition, 'Go to definition', opts)
    kmap('n', 'D', vim.lsp.buf.hover, 'LSP Hover', opts)
    kmap('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation', opts)
    kmap('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help', opts)
    kmap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder', opts)
    kmap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder', opts)
    kmap('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, 'List workspace folders', opts)
    kmap('n', '<space>D', vim.lsp.buf.type_definition, '', opts)
    kmap('n', '<space>rn', vim.lsp.buf.rename, 'Rename current element', opts)
    kmap({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, 'Code action', opts)
    kmap('n', 'gr', vim.lsp.buf.references, 'Go to references', opts)
    kmap('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, 'Format file', opts)
  end,
})

-- Rust tools
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      kmap("n", "<M-a>", rt.hover_actions.hover_actions, 'Hover actions', { buffer = bufnr })
      -- Code action groups
      kmap("n", "<Leader>a", rt.code_action_group.code_action_group, 'Code action group', { buffer = bufnr })
    end,
  },
})
kmap('n', '<leader>he', rt.inlay_hints.enable, 'Enable rust inlay hints')
kmap('n', '<leader>hd', rt.inlay_hints.disable, 'Disable rust inlay hints')

-- Neotree
kmap('n', '<M-p>', ':Neotree toggle<CR>', 'Toggle Neotree')

-- telescope
local builtin = require('telescope.builtin')
kmap('n', '<leader>ff', builtin.find_files, 'Telescope find files')
kmap('n', '<leader>fg', builtin.live_grep, 'Telescope live grep')
kmap('n', '<leader>fb', builtin.buffers, 'Telescope find buffers')
kmap('n', '<leader>fh', builtin.help_tags, 'Telescope help tags')
kmap('n', '<leader>fk', builtin.keymaps, 'Telescope keymaps')

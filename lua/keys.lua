-- save & close
vim.keymap.set('n', '<C-s>', ":w<CR>", {})
vim.keymap.set('n', '<C-q>', ":q<CR>", {})

-- splits
vim.keymap.set('n', '<A-q>', ":q<CR>", {})
vim.keymap.set('n', '<A-h>', ":vne<CR>", {})
vim.keymap.set('n', '<A-v>', ":new<CR>", {})

-- Resizing
vim.keymap.set('n', '<A-Up>', "<C-w><C-k>", {})
vim.keymap.set('n', '<A-Down>', "<C-w><C-j>", {})


-- tabs
vim.keymap.set('n', '<A-t>', ":tabnew<CR>", {})
vim.keymap.set('n', '<A-Left>', ":tabprevious<CR>", {})
vim.keymap.set('n', '<A-Right>', ":tabnext<CR>", {})

-- term
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)

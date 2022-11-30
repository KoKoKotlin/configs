vim.wo.number = true
vim.wo.relativenumber = true
vim.bo.autoindent = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.go.smarttab = true
vim.go.encoding = "utf-8"

require("packer").startup(function()
    use 'wbthomason/packer.nvim'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
end)

local gset = vim.api.nvim_set_var
gset("airline_theme", "onedark")
gset("airline_symbols_ascii", 1)

-- keymaps for duplicating brackets and quotes 
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }
keymap("i", "{", "{}<Esc>ha", opts)
keymap("i", "(", "()<Esc>ha", opts)
keymap("i", "[", "[]<Esc>ha", opts)
keymap("i", "<", "<><Esc>ha", opts)
keymap("i", "\"", "\"\"<Esc>ha", opts)
keymap("i", "'", "''<Esc>ha", opts)
keymap("i", "`", "``<Esc>ha", opts)

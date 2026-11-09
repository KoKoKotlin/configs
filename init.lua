-- ~/.config/nvim/init.lua

-- Options (vim.opt sets them globally; vim.bo/vim.wo only hit the current buffer/window)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
-- (encoding is always utf-8 in Neovim)

-- Plugin manager: lazy.nvim (packer.nvim is archived), bootstraps itself on first start
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--branch=stable",
        "https://github.com/folke/lazy.nvim.git", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.airline_theme = "onedark"
vim.g.airline_symbols_ascii = 1

require("lazy").setup({
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",
    -- Auto-close brackets and quotes; smarter than plain insert mappings
    -- (skips over the closing char, doesn't pair `<` in comparisons, ...)
    { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
})

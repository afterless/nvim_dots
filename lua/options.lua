local option = vim.opt
local cmd = vim.cmd

-- Global
option.smartcase = true
option.updatetime = 300
option.splitright = true
--option.showmatch = true
option.showmode = false
-- option.hidden = true
option.showtabline = 2
option.scrolloff = 18
option.termguicolors = true
-- option.completeopt = 'menuone,noselect'
-- option.shortmess:append({ c = true })
option.clipboard:append({ 'unnamedplus' })
option.fillchars = 'eob: '

-- Local to window
option.number = true
option.relativenumber = true
-- option.cursorline = true
option.signcolumn = 'yes'
option.list = true
--option.listchars = 'tab:\\ ,trail:-,eol:↵'
option.foldmethod = 'expr'
option.foldexpr = 'nvim_treesitter#foldexpr()'
option.colorcolumn = '99999'

-- Local to buffer
option.shiftwidth = 4
option.tabstop = 4
option.softtabstop = 4
option.expandtab = true
option.smartindent = true
option.swapfile = false
option.ignorecase = true

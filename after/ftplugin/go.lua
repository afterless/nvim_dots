vim.opt_local.tabstop = 4
vim.opt_local.expandtab = false
vim.opt.indentexpr = 'nvim_treesitter#indent()'

require('cmp').setup.buffer({
    soucres = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})

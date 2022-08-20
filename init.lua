vim.g.tex_flavor = "latex"
vim.g.ultest_deprecation_notice = 0

require('options')

require('luasnip/loaders/from_vscode').lazy_load()

require('setup.autopairs')
require('setup.aerial')
require('setup.telescope')
require('setup.goto')
require('setup.gitsigns')
require('setup.cmp')
require('setup.toggleterm')
require('setup.treesitter')
require('setup.telescope')
require('setup.goto')

require('lsp.lspconfig')
require('lsp.icon')

require('tree')

require('mappings')
require('highlights')
require('setup.dap')
require('autocommands')

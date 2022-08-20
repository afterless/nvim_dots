local treesitter_config = require('nvim-treesitter.configs')

treesitter_config.setup({
    highlight = {
        enable = true,
    },

    context_commentstring = {
        enable = true,
    },

    autotag = { enable = true },

    autopairs = { enable = true },
})

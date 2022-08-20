local gitsigns = require('gitsigns')

gitsigns.setup({
    signs = {
        add = { hl = 'GitSignsAdd', text = '▌' },
        change = { hl = 'GitSignsChange', text='▌' },
        delete = { hl = 'GitSignsDelete', text='▌' },
    },

    current_line_blame = true,
})

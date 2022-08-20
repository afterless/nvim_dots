return {
    efm = {
        filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact'
        },
    },

    lspconfigs = {
        filetypes = {
            'javascript',
        },

        features = {
            'efm',
            'emmet',
            'tailwindcss',
        },
    },

    autoformat = {
        filetypes = {
            'javascript',
            'javascriptreact',
        },
    },

    codeaction = {
        filetypes = {
            'javascript',
            'javascriptreact',
        },
    },

    colors = {
        red = '#F9867B',
        orange = '#CD9731',
        yellow = '#FDCE68',
        green = '#A3EEA0',
        cyan = '#6796E6',
        blue = '#7BE2F9',
        purple = '#E19EF5',
        tomato = '#F44747',
        white = '#FFFFFF',

        background = '#212835',
        dark_background = '#1B212C',

        border = '#3E4451',
        comment = '#5C6370',
        lineNumber = '#495162',
        cursorLine = '#2C313A',
        indent = '#383C44',
    },

    signs = {
        DiagnosticSignError = '',
        DiagnosticSignWarning = '',
        DiagnosticSignsHint = '',
        DiagnosticSignInfo = '﯎',
        CodeActionSign = '',
    },
    --

    statusline = {
        git_branch_enabled = false,
        diagnostic_enabled = true,
        git_diff_enabled = true,
        test_enabled = true,
        line_column_enabled = true,
        tab_enabled = true,
        line_break_enabled = true,
        file_format_enabled = true,
        efm_enabled = true,
        emoji_enabled = true,
        emoji_icon = '',
    },

}

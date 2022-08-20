local map = vim.api.nvim_set_keymap

local telescope = require('telescope.builtin')
local utils_core = require('utils.core')
local format = require('format')
local dap = require("dap")
local goto_preview = require('goto-preview')
local utils_dap = require("utils.dap")
local sidebar = require("sidebar")


local options = { noremap = true }
local cmd_options = { noremap = true, silent = true }

local function cmd_option(callback)
    return { noremap = true, silent = true, callback = callback }
end

vim.g.mapleader = ' '

----------------------------------------
--
--
-- <Leader>h (normal): Move to left window
-- <Leader>l (normal): Move to right window
-- p (normal): Paste code with indent
-- jk (insert): Change to normal mode from insert mode
-- t (terminal): Change to normal mode from terminal mode
--
--
----------------------------------------

--map('n', '<Enter>', 'o<Esc>', options)
map('n', '<Leader>h', '<C-w>h', options)
map('n', '<Leader>l', '<C-w>l', options)
map('n', '<Leader>j', '<C-w>j', options)
map('n', '<Leader>k', '<C-w>k', options)

map('n', 'p', 'p=`]', options)
map('i', 'jk', '<Esc>', options)
map('v', '<C-]', '<Esc>', options)
map('t', '<Esc>', '<C-\\><C-n>', options)
map('v', '<Tab>', '>gv', options)
map('v', '<S-Tab>', '<gv', options)

map('n', '<Leader>q', [[<Cmd>let @/=""<CR>]], cmd_options)
map('n', '<Leader>s', [[:w<CR>]], cmd_options)

map('n', '<Leader>w', '', cmd_option(utils_core.bufdelete))

map('n', '<Leader>m', '', cmd_option(format.format))
map('n', '<Leader>c', '', cmd_option(format.range_format))

-- Telescope
map(
    'n',
    '<Leader>f',
    [[<Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({skip_empty_lines = true})<CR>]],
    cmd_options
)
map('n', '<Leader>o', '', cmd_option(telescope.buffers))
map('n', '<Leader>p', '', cmd_option(utils_core.project_files))
map("n", "<Leader>u", "", cmd_option(telescope.live_grep))

-- DAP
map('n', '<Leader>0', "", cmd_option(utils_dap.toggle_breakpoint))
map('n', '<Leader>1', "", cmd_option(utils_dap.toggle_debug))
map('n', '<Leader>2', "", cmd_option(dap.step_over))
map('n', '<Leader>3', "", cmd_option(dap.step_into))
map('n', '<Leader>4', "", cmd_option(dap.step_out))
map(
    'n',
    '<Leader>9',
    "",
    cmd_option(function()
        require("dapui").float_element("scopes", {width = 40, height = 30})
    end)
)

-- Unit Testing
map('n', '<Leader>t', "", cmd_option(utils_core.toggle_test))
map('n', ']t', "<Plug>(ultest-next-fail)", { noremap = false, silent = true })
map('n', '[t', "<Plug>(ultest-prev-fail)", { noremap = false, silent = true })

-- Sidebar
map(
    'n',
    '<Leader>[',
    "",
    cmd_option(function()
        sidebar.toggle("explorer")
    end)
)
map(
    'n',
    '<Leader>]',
    "",
    cmd_option(function()
        sidebar.toggle("debug")
    end)
)

map("n", "]q", "<Cmd>tabn<CR>", cmd_options)
map("n", "[q", "<Cmd>tabp<CR>", cmd_options)

map('n', '<Leader>z', [[<Cmd>lua require('goto-preview').goto_preview_definition()<CR>]], cmd_options)

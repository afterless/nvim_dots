local api = vim.api
local fn = vim.fn

local setting_statusline = require('settings').statusline

local M = {}

local function get_nvim_lsp_diagnostic(severity)
    if next(vim.lsp.buf_get_clients(0)) == nil then
        return '0 '
    end

    return #vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity }) .. ' '
end

function M.diagnostic_error()
    return get_nvim_lsp_diagnostic(vim.diagnostic.severity.ERROR)
end

function M.diagnostic_warning()
    return get_nvim_lsp_diagnostic(vim.diagnostic.severity.WARN)
end

local function is_test_file()
    local current_test = api.nvim_eval('ultest#status()')
    if current_test['tests'] > 0 then
        return true
    else
        return false
    end
end

local function get_test(field)
    local current_test = api.nvim_eval('ultest#status()')
    return current_test[field] .. ' '
end

function M.tests()
    return get_test('tests')
end

function M.failed()
    return get_test('failed')
end

function M.passed()
    return get_test('passed')
end

function M.running()
    return get_test('running')
end

-- Credit https://github.com/glepnir/galaxyline.nvim/blob/main/lua/galaxyline/provider_vcs.lua
function M.get_hunks_data()
    -- diff data 1:add 2:modified 3:remove
    local diff_data = { 0, 0, 0 }
    if fn.exists('b:gitsigns_status') == 1 then
        local gitsigns_dict = vim.api.nvim_buf_get_var(0, 'gitsigns_status')
        diff_data[1] = tonumber(gitsigns_dict:match('+(%d+)')) or 0
        diff_data[2] = tonumber(gitsigns_dict:match('~(%d+)')) or 0
        diff_data[3] = tonumber(gitsigns_dict:match('-(%d+)')) or 0
    end

    return diff_data
end

local async_load = vim.loop.new_async(vim.schedule_wrap(function()
    local line
    if fn.winwidth(0) > 30 then
        local file_type = vim.bo.filetype
        local is_update = false

        if filetype ~= '' and filetype ~= 'toggleterm' then
            is_update = true
        else
            is_update = false
        end

        line = '%#StatuslineBackground#  '

        -- Left of status line
        if file_type ~= 'Help' then
            -- Git branch
            if setting_statusline.git_branch_enabled then
                line = line .. '  ' .. require('git_utils').branch('') .. '   '
            end

            -- Diagnostic
            if setting_statusline.diagnostic_enabled then
                line = line
                .. '%#StatuslineBackground#    '
                .. '  %#StatuslineDiagnosticsError#'
                .. [[ %{luaeval('require("statusline").diagnostic_error()')}]]
                .. '%#StatuslineDiagnosticsWarning#'
                .. [[ %{luaeval('require("statusline").diagnostic_warning()')}]]
                .. '  '
            end

            -- Git Diff
            if setting_statusline.git_diff_enabled then
                line = line
                    .. '  %#StatuslineDiffAdded#'
                    .. [[ %{luaeval('require("statusline").get_hunks_data()[1]')}]]
                    .. ' %#StatuslineDiffModified#'
                    .. [[ %{luaeval('require("statusline").get_hunks_data()[2]')}]]
                    .. ' %#StatuslineDiffRemoved#'
                    .. [[ %{luaeval('require("statusline").get_hunks_data()[3]')}]]
                    .. '  '
            end

            -- Test result
            if setting_statusline.test_enabled and is_test_file() then
                line = line
                    .. '%#StatuslineTest#'
                    .. [[ %{luaeval('require("statusline").tests()')}]]
                    .. '%#StatuslinePassed#'
                    .. [[ %{luaeval('require("statusline").passed()')}]]
                    .. '%#StatuslineFailed#'
                    .. [[ %{luaeval('require("statusline").failed()')}]]
            end
        end

        -- Right of status line
        line = line .. '%#StatuslineBackground#%='

        -- Line and column
        if setting_statusline.line_column_enabled then
            line = line .. 'Ln %l, Col %c'
        end

        if is_update and fn.winwidth(0) > 80 then
            -- Show indent type and number of spaces
            if setting_statusline.tab_enabled then
                local tab_type = api.nvim_eval('&et') == 1 and 'Spaces: ' or 'Tabe Size: '
                local tab = api.nvim_eval('&tabstop')

                line = line .. '   ' .. tab_type .. tab
            end

            -- Show type of line break
            if setting_statusline.line_break_enabled then
                local line_break

                local os = api.nvim_eval('&fileformat')
                if os == 'unix' then
                    line_break = 'LF'
                elseif os == 'mac' then
                    line_break = 'CR'
                else
                    line_break = 'CRLF'
                end

                line = line .. '   ' .. line_break
            end

            -- Show format of file
            if setting_statusline.file_format_enabled then
                file_type = file_type:gsub('^%l', string.upper)

                line = line .. '   ' .. file_type .. '   '
            end

            -- Show formatters and linters
            if setting_statusline.efm_enabled then
                line = line .. [[%{luaeval('require("format").formatter_status()')}]]
            end
        end

        -- Emoji at the end of the statusline
        if setting_statusline.emoji_enabled then
            line = line .. '   %#StatuslineSmiley#' .. setting_statusline.emoji_icon
        end

        line = line .. '  '
    else
        line = '%#StatuslineEmptyBackground#'
    end

    vim.wo.statusline = line
end))

-- Credit https://github.com/glepnir/galaxyline.nvim/blob/main/lua/galaxyline.lua
function M.load()
    local fileType = vim.bo.filetype
    if fileType == 'dapui_scopes' or fileType == 'dapui_stacks' or fileType == 'aerial' then

        vim.wo.statusline = '%#StatuslineEmptyBackground#'
    else
        async_load:send()
    end
end

return M

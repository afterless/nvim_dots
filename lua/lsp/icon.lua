local fn = vim.fn
local settings = require('settings')

local signs = settings.signs

for type, icon in pairs(signs) do
    fn.sign_define(type, { text = icon, texthl = type, numhl = '' })
end

---@type ChadrcConfig
local M = {}

vim.opt.colorcolumn="80"
M.ui = { theme = 'decay' }
M.plugins = 'custom.plugins'
M.mappings = require('custom.mappings')
return M

local ts_unit = require("nvim-treesitter.ts_utils")
local M = {}
local get_master_node = function()
    local node = ts_unit.get_node_at_cursor()
    if node == nil then
        error('yo')
    end

    local root = ts_unit.get_root_for_node(node)
    local start_row = node:start()
    local parent = node:parent()

    while (parent ~= nil and parent ~= root and parent:start() == start_row) do 
        node = parent
        parent = node:parent()
    end

    return node
end

M.select = function()
    local node = get_master_node()
    local buf = vim.api.nvim_get_current_buf()
    ts_unit.update_selection(buf, node)
end

M.delete = function()
    local node = get_master_node()
    local buf = vim.api.nvim_get_current_buf()
    local start_row, start_col, end_row, end_col = node:range()
    vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, { '' })
end

return M

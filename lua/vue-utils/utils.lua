local api = vim.api
local M = {}

M.set_keymap = function(buf, key, action)
    api.nvim_buf_set_keymap(buf, 'n', key, action, {
        nowait = true, noremap = true, silent = true
    })
end

return M

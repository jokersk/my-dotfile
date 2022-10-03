local i = require('vue-utils/i')
local q = require"vim.treesitter.query"

local get_script = function(bufnr) 
    local script = nil
    local loc = nil
    local language_tree = vim.treesitter.get_parser(bufnr, 'vue')
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[1]:root()
    local query = vim.treesitter.parse_query('vue', [[
    (script_element (raw_text) @script (#offset! @script) )
    ]])
    for _, captures, metadata in query:iter_matches(root, bufnr) do
        script = q.get_node_text(captures[1], bufnr)
        loc = metadata[1]
    end
    if not script then
        error('can not found script in vue file')
    end
    return {
        script = script,
        loc = {
            start_row = loc.range[1],
            start_col = loc.range[2],
            end_row = loc.range[3],
            end_col = loc.range[4],
        }
    }
end
return get_script


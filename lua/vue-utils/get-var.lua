local i = require('vue-utils/i')
local q = require"vim.treesitter.query"

local get_props_loc = function(str) 
    local loc
    local parser = vim.treesitter.get_string_parser(str, 'typescript')
    local root = parser:parse()[1]:root()
    local map = {}
    local query = vim.treesitter.parse_query('typescript', [[
    (lexical_declaration 
        (variable_declarator
            name: (identifier) @identifier (#offset! @identifier)
        )
    )]])
    for _, captures, metadata in query:iter_matches(root, str) do
        local result = {}
        local loc = metadata.content[1]
        result['name'] = q.get_node_text(captures[1], str)
        result['row'] = loc[1]
        result['col'] = loc[2]
        table.insert(map, result)
    end
    return map
end

return get_props_loc 

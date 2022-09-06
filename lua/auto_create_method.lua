local q = require"vim.treesitter.query"
local ts_utils = require"nvim-treesitter.ts_utils"
local ts_indent = require"nvim-treesitter.indent"


local function i(value)
    print(vim.inspect(value))
end

local function t(node)
    return ts_utils.get_node_text(node)
end

local bufnr = vim.api.nvim_get_current_buf()


local function findCallingMethod(node)
    local parent = node:parent()
    if parent == nil then return node end
    if parent:type() == 'method_declaration' then
        return parent
    end
    return findCallingMethod(parent)
end

local function find_child_by_type(node, type)
    for child in node:iter_children() do
        if child:type() == type then
            return child
        end
    end
end

local function find_children_by_type(node, type)
    local result = {}
    for child in node:iter_children() do
        if child:type() == type then
            table.insert(result, child)
        end
    end
    return result
end

local function first(table)
    for _,value in ipairs(table) do
        return value
    end
end

local function findInsideMethods(node)
    local result = {}
    local compound_statement = find_child_by_type(node, 'compound_statement')
    local expression_statements = find_children_by_type(compound_statement, 'expression_statement')
    local names = {}
    for key,value in ipairs(expression_statements) do
        local name = ts_utils.get_node_text(find_child_by_type(find_child_by_type(value, 'member_call_expression'), 'name'))
        table.insert(names, first(name))
    end
    return names
end

local function getMethodsInClass()
    local query = vim.treesitter.parse_query('php', [[
        (class_declaration
            (declaration_list
                (method_declaration) @methods
            )
        )
    ]])

    local methods = {}
    local language_tree = vim.treesitter.get_parser(bufnr, 'php')
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[1]:root()
    for _,captures,metadata in query:iter_matches(root, bufnr) do
        local name = find_child_by_type(captures[1], 'name')
        name = ts_utils.get_node_text(name)
        table.insert(methods, first(name))
    end
    return methods
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local function getDiff(table1, table2)
    local result = {}
    for _,value in ipairs(table2) do
        if not table.contains(table1, value) then
            table.insert(result, value)
        end
    end
    return result
end

local function createMethod(diff, start_line)
    local tab_space = get_indent_str(start_line)
    local newMethod = {}
    local add_line = function(line)
        table.insert(newMethod, tab_space .. line)
    end

    for _,method_name in ipairs(diff) do
        add_line(string.format("protected function %s() {", method_name))
        add_line("}")
    end
    table.insert(newMethod, '')
    vim.api.nvim_buf_set_text(bufnr, start_line, 0, start_line, 0, newMethod)
end

function get_indent_str(line)
    local indent_count = ts_indent.get_indent(line)
    if indent_count == 0 then
        return ""
    end
    local tabstop = vim.o.tabstop
    local ntabs = (indent_count / tabstop)
    local tab_space = ""
    
    if vim.o.expandtab then
        tab_space = string.rep(" ", tabstop * ntabs)
    else
        tab_space = string.rep("\t", ntabs)
    end

    return tab_space
end

local run  = function()
    local currentNode = ts_utils.get_node_at_cursor()
    local callingMethod = findCallingMethod(currentNode)
    local insideMethods = findInsideMethods(callingMethod)
    local methodsInClass = getMethodsInClass()
    local diff = getDiff(methodsInClass, insideMethods)
    createMethod(diff, callingMethod:end_() + 1)
end

run()

return {
    run = run
}

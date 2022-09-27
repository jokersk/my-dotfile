local ts_unit = require("nvim-treesitter.ts_utils")
local parsers = require "nvim-treesitter.parsers"
local api = vim.api
local buf, win
local M = {}
local window = require('./window')
local create_window = window.create_pop 
local center = window.center
buf = vim.api.nvim_get_current_buf()

local function i(value)
    print(vim.inspect(value))
end

local first = function(tbl)
    for k,v in pairs(tbl) do
        return v
    end
end

local get_root_node = function() 
    local buf = api.nvim_get_current_buf()
    local root_lang_tree = parsers.get_parser(buf)
    if not root_lang_tree then
        error('no root_lang_tree')
    end

    for _, tree in ipairs(root_lang_tree:trees()) do
        local tree_root = tree:root()
        if tree_root then
            return tree_root
        end
    end

    error('can not found root node')
end


local get_script = function()
    local root_node = get_root_node()
    for child in root_node:iter_children() do
        if child:type() == 'script_element' then
            return child
        end
    end
    error('can not found script element')
end


local function open_window()
    local c = create_window()
    buf = c['buf']
    win = c['win']
end


local function update_view(content)
    api.nvim_buf_set_lines(buf, 0, -1, false, {
      center('Methods of this Class:')
    })

    api.nvim_buf_set_lines(buf, 3, -1, false, content)

    api.nvim_buf_set_option(buf, 'modifiable', false)
end

local get_declaration_list = function(class_node)
    local child = nil
    local total = class_node:child_count()
    for i = 0,total,1 do
        child = class_node:child(i)
        if child:type() == 'declaration_list' then
            break
        end
    end
    return child
end

local getcontent = function(node)
    local buf = vim.api.nvim_get_current_buf()
    return ts_unit.get_node_text(node, buf) 
end

local get_first_named_child = function(node)
    local child = nil
    for i=0,node:named_child_count() do
        child = node:named_child(i)
        if child ~= nil and child:type() == 'name' then
            break
        end
    end
    if child == nil then
        error('can not found first named child')
    end
    return child
end

local get_child = function(node, callback)
    local child
    for i=0,node:child_count() do
        child = node:child(i)
        if child ~= nil and callback(child) then
            break
        end
    end
    if child == nil then
        error('can not found child')
    end
    return child
end

local get_method_declaration = function(node)
    local child
    local result = {}
    local total = node:child_count() 
    for i=1,total do
        child = node:child(i)
        if child ~= nil and child:type() == 'method_declaration' then
            result[i] = get_first_named_child(child)
        end
    end
    return result
end

local map = function(tbl, callback)
    local t = {}
    for k,v in pairs(tbl) do
        table.insert(t, callback(v))
    end
    return t
end


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local merge = function(first_table, second_table)
    for _, v in pairs(second_table) do table.insert(first_table, v) end
    return first_table
end


local methods = {}
local store_global_methods = function(m)
    for _,v in pairs(m) do
        methods[first(getcontent(v))] = v
    end
end

local goto = function(string_node)
    local node = methods[string_node]
    ts_unit.goto_node(node)
end

M.close_window = function()
  api.nvim_win_close(win, true)
end

M.click = function()
    local str = api.nvim_get_current_line()
    M.close_window()
    goto(str)
end

local map_keys = function()
    api.nvim_buf_set_keymap(buf, 'n', '<cr>', ':lua require"methods".click()<cr>', {
        nowait = true, noremap = true, silent = true
    })
    api.nvim_buf_set_keymap(buf, 'n', 'q', ':lua require"methods".close_window()<cr>', {
        nowait = true, noremap = true, silent = true
    })
end

M.select = function()
    local query = vim.treesitter.parse_query('javascript', '(lexical_declaration) @foo')

    local language_tree = vim.treesitter.get_parser(buf, 'vue')
    local syntax_tree = language_tree:parse()
    local root = syntax_tree[1]:root()

    for _,captures,metadata in query:iter_matches(root, buf) do
        print(1)
    end

    --[[ local script_element = get_script()
    local raw = get_child(script_element, function(child)
        if child:type() == 'raw_text' then
            return true
        end
    end)

    local lexical_declarations = get_child(raw, function(child)
        return true
    end) 
    i(ts_unit.get_node_text(lexical_declarations, buf)) ]]
end

M.select()

return M

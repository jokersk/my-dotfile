if !exists('g:lspconfig')
  finish
endif

lua << EOF
local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>', opts)
  -- require'completion'.on_attach(client, bufnr)
  -- vim.api.nvim_command [[augroup Format]]
  -- vim.api.nvim_command [[autocmd! * <buffer>]]
  -- vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
  --vim.api.nvim_command [[augroup END]]
end

nvim_lsp.intelephense.setup{
  on_attach = on_attach
}

require'lspconfig'.pyright.setup{}

require'lspconfig'.volar.setup {
    on_attach = function(client, bufnr) 
        print('volar attach!')
        on_attach(client, bufnr)
    end,
    init_options = {
        typescript = {
          serverPath = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
        }
    },
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
}

-- nvim_lsp.vuels.setup {
--   on_attach = function(client, bufnr)
--     print('wa, vuels attach')
--     client.resolved_capabilities.document_formatting = true
--     on_attach(client, bufnr)
--   end,
--   settings = {
--     vetur = {
--         completion = {
--             autoImport = true,
--             useScaffoldSnippets = true
--         },
--         format = {
--             defaultFormatter = {
--                 html = "prettier",
--                 js = "prettier",
--                 ts = "prettier",
--             }
--         },
--         validation = {
--             template = false,
--             script = true,
--             style = false,
--             templateProps = true,
--             interpolation = true
--         },
--         experimental = {
--             templateInterpolationService = false
--         }
--       }
--   }
-- }

nvim_lsp.tsserver.setup({
    -- Needed for inlayHints. Merge this table with your settings or copy
    -- it from the source if you want to add your own init_options.
    init_options = require("nvim-lsp-ts-utils").init_options,
    --
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")
        print('tsserver attach now, have a nice day')

        -- defaults
        ts_utils.setup({
            debug = false,
            disable_commands = false,
            enable_import_on_completion = false,

            -- import all
            import_all_timeout = 5000, -- ms
            -- lower numbers = higher priority
            import_all_priorities = {
                same_file = 1, -- add to existing import statement
                local_files = 2, -- git files or files with relative path markers
                buffer_content = 3, -- loaded buffer content
                buffers = 4, -- loaded buffer names
            },
            import_all_scan_buffers = 100,
            import_all_select_source = false,
            -- if false will avoid organizing imports
            always_organize_imports = true,

            -- filter diagnostics
            filter_out_diagnostics_by_severity = {},
            filter_out_diagnostics_by_code = {},

            -- inlay hints
            auto_inlay_hints = true,
            inlay_hints_highlight = "Comment",
            inlay_hints_priority = 200, -- priority of the hint extmarks
            inlay_hints_throttle = 150, -- throttle the inlay hint request
            inlay_hints_format = { -- format options for individual hint kind
                Type = {},
                Parameter = {},
                Enum = {},
                -- Example format customization for `Type` kind:
                -- Type = {
                --     highlight = "Comment",
                --     text = function(text)
                --         return "->" .. text:sub(2)
                --     end,
                -- },
            },

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = nil,
        })

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local opts = { silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
    end,
})

require'lspconfig'.solang.setup{}


nvim_lsp.html.setup {
  on_attach = on_attach,
  lsp = {
	on_attach = on_attach
  }
}

require'lualine'.setup{
  options = {theme = 'codedark'}
}

 require'flutter-tools'.setup {
   debugger = {
     enable = true
   },
   lsp = {
 	on_attach = on_attach
   }
 }

require'nvim-tree'.setup {
    git = {
        enable = false,
    },
    update_cwd = true,
    update_focused_file = {
        enable = false,
        update_cwd = true,
    },
  filters = {},
  view = {
    width = 40,
    side = "right",
    hide_root_folder = false,
    mappings = {
        custom_only = false,
        list = list_keys,
    },
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
  }
}

 require'nvim-treesitter.configs'.setup {
   highlight = {
     enable = true,
     disable = { "dart" },
   }
 }

require'lspconfig'.tailwindcss.setup{}

require'neoscroll'.setup{
  mappings = {'<C-u>', '<C-d>', '<C-f>', 'zt', 'zz', 'zb'},
}

vim.opt.list = true

require("indent_blankline").setup {
    show_end_of_line = true,
    filetype_exclude = {
        "dashboard",
    }
}


local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '100'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '100'}}
t['zt']    = {'zt', {'100'}}
t['zz']    = {'zz', {'100'}}
t['zb']    = {'zb', {'100'}}

require('neoscroll.config').set_mappings(t)

require'nvim-terminal'.setup {}
vim.api.nvim_set_keymap('n', '<leader>t', ':lua NTGlobal["terminal"]:toggle()<cr>', { silent = true })
require('telescope').setup{
    defaults = {
        file_ignore_patterns = {"node_modules", "vendor", "storage/.*"}
    }
}

require("dapui").setup()
require("nvim-dap-virtual-text").setup()

--- dap keymaps
vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F4>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dapui'.open()<CR>")

local dap = require('dap')
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/Users/jokersk/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003
  }
}

EOF




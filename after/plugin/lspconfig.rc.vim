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

nvim_lsp.vuels.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    on_attach(client, bufnr)
  end,
  settings = {
    vetur = {
        completion = {
            autoImport = true,
            useScaffoldSnippets = true
        },
        format = {
            defaultFormatter = {
                html = "prettier",
                js = "prettier",
                ts = "prettier",
            }
        },
        validation = {
            template = false,
            script = true,
            style = true,
            templateProps = true,
            interpolation = false
        },
        experimental = {
            templateInterpolationService = false
        }
      }
  }
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach
}

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
} -- use defaults

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
     disable = {},
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
EOF




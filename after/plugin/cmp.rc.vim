lua << EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

        -- For `luasnip` user.
        -- require('luasnip').lsp_expand(args.body)

        -- For `ultisnips` user.
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
      { name = 'nvim_lsp' },

      -- For vsnip user.
      -- { name = 'vsnip' },

      --For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      { name = 'ultisnips' },

      { name = 'buffer' },
    }
  })
  -- Setup lspconfig.
  require('lspconfig')['intelephense'].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF

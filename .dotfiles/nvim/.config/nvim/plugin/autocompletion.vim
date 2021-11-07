" Autocompletion configuration.


set completeopt=menu,menuone

lua <<EOF

  local luasnip = require 'luasnip'

  local cmp = require'cmp'

  cmp.setup({
    -- TODO: Learn how to use Snippets?
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<Tab>'] = function(fallback)
        local cmp = require('cmp')
        if #cmp.core:get_sources() > 0 and not cmp.get_config().experimental.native_menu then
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            cmp.complete()
          end
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        local cmp = require('cmp')
        if #cmp.core:get_sources() > 0 and not cmp.get_config().experimental.native_menu then
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            cmp.complete()
          end
        else
          fallback()
        end
      end,
      ['<C-y>'] = cmp.config.disable,
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- TODO: Learn how to use Snippets?
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
    })
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'cmdline' }
    })
  })

EOF

return function()
  local cmp = require('cmp')
--  local lspkind = require('lspkind')

  cmp.setup{
	  snippet = {
		  -- REQUIRED - you must specify a snippet engine
		  expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--			require'luasnip'.lsp_expand(args.body) -- Luasnip expand
	    end,
	  },

    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm(
      {
        -- behavior = cmp.ConfirmBehavior.Replace,
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }
      ), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),


--[[
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },                -- LSP 👄
		{ name = 'nvim_lsp_signature_help' }, -- Помощь при введении параметров в методах 🚁
		{ name = 'luasnip' },                 -- Luasnip 🐌
		{ name = 'buffer' },                  -- Буфферы 🐃
		{ name = 'path' },                    -- Пути 🪤
		{ name = "emoji" },                   -- Эмодзи 😳
	}, {
	}),
]]--

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'buffer' },
		  { name = 'path' },
    }),


--[[
	  formatting = {
		  format = lspkind.cmp_format({
			  mode = 'symbol', -- show only symbol annotations
			  maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		  })
	  }
]]--
  }
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true,
      inlay_hints = false,
      semantic_tokens = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {
          "go",
          "python",
          "html",
          "JavaScript",
          "TypeScript",
          "Lua",
          "yaml",
          "groovy"
        },
        ignore_filetypes = {},
      },
      disabled = {},
      timeout_ms = 1000,
    },
    servers = {
      "lua_ls",
      "vimls",
      "bashls",
      "gopls",
      "groovyls", -- Groovy Language Server
      "html",
      "ts_ls",
      "pyright",
      "terraformls",
      "taplo",
      "yamlls",
    },
    config = {
      -- Custom configuration for Groovy Language Server
      groovyls = {
        cmd = { "java", "-jar", "/home/ender/groovy-language-server/build/libs/groovy-language-server-all.jar" },
        filetypes = { "groovy" },
        root_dir = function()
          return vim.fn.getcwd()
        end,
      },
      clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
    handlers = {
      pyright = function(_, opts)
        function filter_diagnostics(diagnostic)
          if diagnostic.source ~= "Pyright" then return true end
          if string.match(diagnostic.message, "Expression value is unused") then return false end
          if string.match(diagnostic.message, '"_.+" is not accessed') then return false end
          return true
        end

        function custom_on_publish_diagnostics(a, params, client_id, c, config)
          local diagnostics = params.diagnostics
          local new_diagnostics = {}
          for _, diagnostic in ipairs(diagnostics) do
            if filter_diagnostics(diagnostic) then table.insert(new_diagnostics, diagnostic) end
          end
          params.diagnostics = new_diagnostics
          vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c, config)
        end

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {})
        require("lspconfig").pyright.setup(opts)
      end,
    },
    autocmds = {
      lsp_codelens_refresh = {
        cond = "textDocument/codeLens",
        {
          event = { "InsertLeave", "BufEnter" },
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    mappings = {
      n = {
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
          end,
        },
      },
    },
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}

-- Customize Mason plugins

---@type LazySpec
return {
  -- Use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- Overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",          -- Lua LSP
        "pyright",         -- Python LSP
        "gopls",           -- Go LSP
        "html",            -- HTML LSP
        "ts_ls",           -- JavaScript/TypeScript LSP
        "terraformls",     -- Terraform LSP
        "yamlls",          -- YAML LSP
        "bashls",          -- Bash LSP
        --"groovyls"
      },
    },
  },
  -- Use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- Overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        -- Lua
        "stylua",          -- Lua formatter
        -- Python
        "black",           -- Python formatter
        "flake8",          -- Python linter
        -- Go
        "gofmt",           -- Go formatter
        "golangci-lint",   -- Go linter
        -- JavaScript/TypeScript
        "prettier",        -- JS/TS/HTML formatter
        "eslint_d",        -- JS/TS linter (fast ESLint)
        -- Terraform
        "terraform_fmt",   -- Terraform formatter
        "tflint",          -- Terraform linter
        -- YAML
        "yamlfmt",         -- YAML formatter
        "yamllint",        -- YAML linter
        -- Bash
        "shfmt",           -- Bash formatter
        "shellcheck",      -- Bash linter
        -- HTML (using Prettier as the formatter for HTML)
        "prettier",
      },
    },
  },
  -- Use mason-nvim-dap to configure debuggers installation for nvim-dap
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- Overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",         -- Python debugger for nvim-dap
        -- Add more debuggers here if needed
      },
    },
  },
}

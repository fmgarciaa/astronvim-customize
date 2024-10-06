--- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",            -- Lua parser
      "vim",            -- Vimscript parser
      "go",             -- Go parser
      "html",           -- HTML parser
      "javascript",     -- JavaScript parser
      "typescript",     -- TypeScript parser
      "terraform",      -- Terraform parser
      "yaml",           -- YAML parser
      "bash",           -- Bash parser
      "python",         -- Python parser
      -- add more arguments for adding more treesitter parsers if needed
    },
  },
}

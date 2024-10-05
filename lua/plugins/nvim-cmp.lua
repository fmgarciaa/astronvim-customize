-- lua/plugins/nvim-cmp.lua
return {
  {
    "hrsh7th/nvim-cmp", -- Core nvim-cmp plugin
    dependencies = {
      {
        "tzachar/cmp-tabnine", -- TabNine AI completion source
        build = "./install.sh", -- Ensures TabNine binary is installed
        dependencies = "hrsh7th/nvim-cmp", -- Ensure nvim-cmp is installed first
      },
    },
    opts = function(_, opts)
      -- Require nvim-cmp for autocompletion functionality
      local cmp = require "cmp"

      -- Customize key mappings for nvim-cmp
      opts.mapping = {
        -- Use Ctrl+Space to manually trigger autocompletion
        ["<C-Space>"] = cmp.mapping.complete(),
        -- Press Enter to confirm the selected completion item
        ["<CR>"] = cmp.mapping.confirm { select = true },
        -- Navigate to the next item in the suggestion list with Tab
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- Navigate to the previous item with Shift+Tab
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }

      -- Customize the completion sources
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP-based autocompletion
        { name = "vsnip" }, -- Snippet autocompletion using vsnip
        { name = "cmp_tabnine" }, -- AI-based autocompletion from TabNine
      }, {
        { name = "buffer" }, -- Suggestions based on the current buffer
      })

      -- Configure TabNine for better performance
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000, -- Limit TabNine to scan 1000 lines for context
        max_num_results = 20, -- Limit the number of suggestions to 20 results
        sort = true, -- Enable sorting of TabNine suggestions
        run_on_every_keystroke = true, -- Run TabNine on every keystroke
        snippet_placeholder = "..", -- Placeholder text for snippets in TabNine suggestions
        api_key = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImlhdCI6MTcyNjY3NDU3MSwiZXhwIjoxNzI2Njc4MTcxLCJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay02cjM0eUB0YWJuaW5lLWF1dGgtMzQwMDE1LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwic3ViIjoiZmlyZWJhc2UtYWRtaW5zZGstNnIzNHlAdGFibmluZS1hdXRoLTM0MDAxNS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInVpZCI6IkhrVElCU3BwdGxoSmhuVEFOd1hZVTVtcFIyVjIifQ.W3ncdSFT3zzZwILqm8rFE4q70S7hG9rHDG1Q3mhq-X3ttUTU_bAJDtNevg9BJaQDQij-5d3PaST9xtwYUelTrWELpI04jJjcFXpCepu2xCP4jKRfRmn3OuxPJdpas1SzFL8_kabuSSS-fJVEW4c18B5ohorC4hQTXn2GbRHOau54vR3QYgLgnrClq_aJBhVHxzR0y10UOiCJDGQJvlq7MRupQknHJwTIUHbUaGyUdwkU8adE_n8qv4t660I5hF_aDNhzANQjWMQOJUERvR4k55pD4NHCxuZF5VHI5n3pnDaeGOzmMbDNv2KERZ2MnG-id5wehmTg-nKFMeWNfqQCBQ",
      }
    end,
  },
}


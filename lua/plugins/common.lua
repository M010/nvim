return {
  "folke/which-key.nvim",
  'nvim-lua/plenary.nvim',
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    ensure_installed = "clangd",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 999,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
    },
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    config = false,
    lazy = true,
  }
}

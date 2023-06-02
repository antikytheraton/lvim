------------------------------------------------------
-- Plugins
------------------------------------------------------
lvim.plugins = {
  -- TMUX navigator
  { "christoomey/vim-tmux-navigator" },
  { "tmux-plugins/vim-tmux-focus-events" },
  -- Enhanced movement plugin
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  -- Go development
  {
    "fatih/vim-go",
    build = ":GoUpdateBinaries",
  },
  -- Treesitter complements
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "lewis6991/spellsitter.nvim",
    config = function()
      require("spellsitter").setup()
    end,
  },
  -- mkdir
  { "pbrisbin/vim-mkdir" },
  -- Wakatime
  { "wakatime/vim-wakatime" },
  -- LSP fidget
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end,
  },
  -- File explorer
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("config.nnn").setup()
    end,
  },
  -- autosession
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
      })
    end,
  },
  -- clipboard management
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("neoclip").setup()
    end,
  },
  -- python formatting
  { "psf/black" },
}

return {
  "petertriho/nvim-scrollbar",
  lazy = false,
  config = function()
    require("scrollbar").setup()
    require("scrollbar.handlers.gitsigns").setup()
  end,
}

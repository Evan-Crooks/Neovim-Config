return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "cpp",
          "qmljs",
        },

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },
}

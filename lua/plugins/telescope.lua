return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },

    config = function()
      require("telescope").setup({
        defaults = {
          -- Lua patterns for common compiled files, archives, and binary assets.
          file_ignore_patterns = {
            "%.o$", "%.obj$", "%.a$", "%.so$", "%.so%.[%d.]+$",
            "%.dll$", "%.exe$", "%.bin$", "%.out$", "%.class$", "%.pyc$",
            "%.pyo$", "%.dylib$", "%.wasm$",
            "%.zip$", "%.gz$", "%.bz2$", "%.xz$", "%.7z$", "%.rar$",
            "%.tar$", "%.jar$", "%.png$", "%.jpe?g$", "%.gif$",
            "%.webp$", "%.ico$", "%.bmp$", "%.pdf$",
            "%.mp[34]$", "%.wav$", "%.ogg$", "%.flac$", "%.mov$",
            "%.avi$", "%.mkv$", "%.woff2?$", "%.ttf$", "%.otf$",
          },
        },
      })

      require("telescope").load_extension("fzf")
    end,
  },
}

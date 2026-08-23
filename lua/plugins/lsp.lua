return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("qmlls", {
        cmd = { "qmlls", "-E" },
        filetypes = { "qml", "qmljs" },

        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local root = vim.fs.root(fname, { ".git", "qmldir" })

          if root then
            on_dir(root)
          end
        end,
      })

      vim.lsp.enable("qmlls")
    end,
  },
}

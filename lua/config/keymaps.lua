vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end, {
    desc = "Find files",
  })

vim.keymap.set("n", "<M-F>", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! gg=G")
  vim.api.nvim_win_set_cursor(0, pos)
end, {
    desc = "Indent entire file",
  })

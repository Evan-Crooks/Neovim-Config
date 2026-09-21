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
-- Move current line down/up with Alt+j / Alt+k
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Move selected lines down/up with Alt+j / Alt+k
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<leader>ac", function()
  require("config.codex").toggle()
end, { desc = "Toggle Codex Sidebar" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

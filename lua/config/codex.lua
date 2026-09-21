local M = {}
local buf

function M.toggle()
  if buf and vim.api.nvim_buf_is_valid(buf) then
    local win = vim.fn.bufwinid(buf)
    if win ~= -1 then
      vim.api.nvim_win_hide(win)
      return
    end
  else
    if vim.fn.executable("codex") ~= 1 then
      vim.notify("codex is not available on PATH", vim.log.levels.ERROR)
      return
    end
    buf = nil
  end

  local cwd = vim.fn.getcwd()
  vim.cmd("botright vsplit")
  vim.api.nvim_win_set_width(0, math.max(1, math.floor(vim.o.columns * 0.35)))

  if buf then
    vim.api.nvim_win_set_buf(0, buf)
  else
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.bo[buf].bufhidden = "hide"
    vim.fn.jobstart({ "codex" }, { term = true, cwd = cwd })
    for _, direction in ipairs({ "h", "j", "k", "l" }) do
      vim.keymap.set("t", "<C-w>" .. direction, "<C-\\><C-n><C-w>" .. direction, {
        buffer = buf,
        desc = "Move from Codex to adjacent window",
      })
    end
  end

  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.winfixwidth = true
  vim.cmd("startinsert")
end

return M

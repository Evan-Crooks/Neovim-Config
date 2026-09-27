vim.opt.mouse = "a"
vim.opt.mousemoveevent = true

local float_win
local hovered_win, hovered_line

local function close_float()
  if float_win and vim.api.nvim_win_is_valid(float_win) then
    vim.api.nvim_win_close(float_win, true)
  end
  float_win, hovered_win, hovered_line = nil, nil, nil
end

vim.keymap.set({ "n", "i", "v" }, "<MouseMove>", function()
  local mouse = vim.fn.getmousepos()
  if mouse.winid == 0 or not vim.api.nvim_win_is_valid(mouse.winid) then
    close_float()
    return
  end

  local info = vim.fn.getwininfo(mouse.winid)[1]
  -- The gutter includes diagnostic signs, line numbers, and fold markers.
  if not info or mouse.line == 0 or mouse.wincol > info.textoff then
    close_float()
    return
  end

  if hovered_win == mouse.winid and hovered_line == mouse.line
      and float_win and vim.api.nvim_win_is_valid(float_win) then
    return
  end
  close_float()

  local bufnr = vim.api.nvim_win_get_buf(mouse.winid)
  if #vim.diagnostic.get(bufnr, { lnum = mouse.line - 1 }) == 0 then
    return
  end

  vim.api.nvim_win_call(mouse.winid, function()
    local _, win = vim.diagnostic.open_float({
      bufnr = bufnr,
      scope = "line",
      pos = mouse.line - 1,
      focus = false,
      focusable = false,
      border = "rounded",
      source = "if_many",
      relative = "mouse",
      close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter", "WinScrolled" },
    })
    float_win = win
  end)
  hovered_win, hovered_line = mouse.winid, mouse.line
end, { desc = "Show diagnostics when hovering over the gutter" })

function _G.cm_qf_formatter(info)
  local items
  local res = {}

  if info.quickfix == 1 then
    items = vim.fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = vim.fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end

  local max_fname_len = 0
  for i = info.start_idx, info.end_idx do
    local item = items[i]
    if item.valid == 1 and item.bufnr > 0 then
      local fname = vim.fn.bufname(item.bufnr)
      if fname == "" then
        fname = "[No Name]"
      end

      if #fname > 50 then
        fname = "..." .. fname:sub(-47)
      end

      item.fname = fname
      max_fname_len = math.max(max_fname_len, #fname)
    else
      item.fname = ""
    end
  end

  local format = "%" .. tostring(max_fname_len) .. "s:%-3d%s | %s"

  for i = info.start_idx, info.end_idx do
    local item = items[i]
    local str = item.text
    if item.valid == 1 then
      local qtype = item.type == "" and "" or (" (" .. item.type:sub(1, 1):upper() .. ")")
      str = string.format(format, item.fname, item.lnum, qtype, item.text)
    end

    table.insert(res, str)
  end

  return res
end

vim.o.quickfixtextfunc = "{info -> v:lua._G.cm_qf_formatter(info)}"

-- https://github.com/rmarganti/.dotfiles/blob/main/dots/.config/nvim/lua/rmarganti/core/autocommands.lua#L12
local function delete_qf_items()
  local mode = vim.api.nvim_get_mode()['mode']

  local start_idx
  local count

  if mode == 'n' then
    -- Normal mode
    start_idx = vim.fn.line('.')
    count = vim.v.count > 0 and vim.v.count or 1
  else
    -- Visual mode
    local v_start_idx = vim.fn.line('v')
    local v_end_idx = vim.fn.line('.')

    start_idx = math.min(v_start_idx, v_end_idx)
    count = math.abs(v_end_idx - v_start_idx) + 1

    -- Go back to normal
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(
        '<esc>',         -- what to escape
        true,            -- Vim leftovers
        false,           -- Also replace `<lt>`?
        true             -- Replace keycodes (like `<esc>`)?
      ),
      'x',               -- Mode flag
      false              -- Should be false, since we already `nvim_replace_termcodes()`
    )
  end

  local qflist = vim.fn.getqflist()

  for _ = 1, count, 1 do
    table.remove(qflist, start_idx)
  end

  vim.fn.setqflist(qflist, 'r')
  vim.fn.cursor(start_idx, 1)
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('QuickfixTweaks', { clear = true }),
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', delete_qf_items, { buffer = true })
    vim.keymap.set('x', 'd', delete_qf_items, { buffer = true })
  end
})


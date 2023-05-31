local M = {}

M.config = {
  replace_netrw = "picker",
}

M.setup = function()
  local status_ok, nnn = pcall(require, "nnn")
  if not status_ok then
    return
  end
  nnn.setup(M.config)
end

return M

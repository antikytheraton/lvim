local M = {}

M.config = {
	dir = vim.fn.expand(vim.fn.stdpath("config") .. "/.session/"),
	options = { "buffers", "curdir", "tabpages", "winsize" },
}

M.setup = function()
	local status_ok, persistence = pcall(require, "persistence")
	if not status_ok then
		return
	end

	persistence.setup(M.config)
end

return M

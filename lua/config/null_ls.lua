------------------------------------------------------
-- LSP Formatters and Linters
------------------------------------------------------

lvim.format_on_save.enabled = true

local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

formatters.setup({
	{ exe = "black", filetypes = { "python" } },
	{ exe = "stylua", filetypes = { "lua" } },
	{ exe = "goimports", filetypes = { "go" } },
	{ exe = "gofumpt", filetypes = { "go" } },
	{ exe = "rustfmt", filetypes = { "rust" } },
})

linters.setup({
	-- { exe = "mypy", filetypes = { "python" } },
	{ exe = "ruff", filetypes = { "python" } },
	{ exe = "pylama", filetypes = { "python" } },
	{ exe = "flake8", filetypes = { "python" } },
	{ exe = "golangci-lint", filetypes = { "go" } },
})

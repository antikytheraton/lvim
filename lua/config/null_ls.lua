------------------------------------------------------
-- LSP Formatters and Linters
------------------------------------------------------

lvim.format_on_save.enabled = true

local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")

linters.setup({
	-- { exe = "mypy", filetypes = { "python" } },
	{ exe = "ruff", filetypes = { "python" } },
	{ exe = "pylama", filetypes = { "python" } },
	{ exe = "flake8", filetypes = { "python" } },
	{ exe = "pyproject_flake8", filetypes = { "python" } },
	{ exe = "golangci-lint", filetypes = { "go" } },
})

formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },

	{ exe = "black", filetypes = { "python" } },
	-- { exe = "blue", filetypes = { "python" } },
	-- { exe = "pyink", filetypes = { "python" } },
	{ exe = "ruff", filetypes = { "python" } },
	-- { exe = "isort", filetypes = { "python" } },
	{ exe = "reorder_python_imports", filetypes = { "python" } },
	{ exe = "djlint", filetypes = { "django", "jinja.html", "htmldjango" } },
	-- { exe = "djhtml", filetypes = { "django", "jinja.html", "htmldjango" } },

	{ exe = "goimports", filetypes = { "go" } },
	{ exe = "gofumpt", filetypes = { "go" } },

	{ exe = "rustfmt", filetypes = { "rust" } },
})

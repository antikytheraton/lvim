------------------------------------------------------
-- LSP Formatters and Linters
------------------------------------------------------

lvim.format_on_save.enabled = false

local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")
local code_actions = require("lvim.lsp.null-ls.code_actions")

linters.setup({
	{ exe = "ruff", filetypes = { "python" } },
	{ exe = "golangci-lint", filetypes = { "go" } },
	-- { name = "codespell" },
	{ name = "terraform_validate" },
	{ name = "curlylint" },
	{ name = "shellcheck", args = { "--severity", "info", "-e", "SC2034" } },
	{ name = "checkmake" },
})

code_actions.setup({
	{ name = "proselint" },
	-- { name = "refactoring" },
})

formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },

	-- { exe = "black", filetypes = { "python" } },
	-- { exe = "blue", filetypes = { "python" } },
	{ exe = "pyink", filetypes = { "python" } },
	-- { exe = "ruff", filetypes = { "python" } },
	-- { exe = "isort", filetypes = { "python" } },
	{ exe = "reorder_python_imports", filetypes = { "python" } },
	{ exe = "djlint", filetypes = { "django", "jinja.html", "htmldjango", "djhtml" } },
	-- { exe = "djhtml", filetypes = { "django", "jinja.html", "htmldjango" } },

	{ exe = "goimports", filetypes = { "go" } },
	{ exe = "gofumpt", filetypes = { "go" } },

	{ name = "rustfmt" },
	{ name = "cmake_format" },
	{ name = "prettier" },
	{ name = "beautysh" },
	{ name = "sqlfmt" },
})

------------------------------------------------------
-- LSP Formatters and Linters
------------------------------------------------------

lvim.format_on_save.enabled = false

local formatters = require("lvim.lsp.null-ls.formatters")
local linters = require("lvim.lsp.null-ls.linters")
local code_actions = require("lvim.lsp.null-ls.code_actions")
-- local completion = require("lvim.lsp.null-ls.completion")

linters.setup({
	-- { exe = "mypy", filetypes = { "python" } },
	{ exe = "ruff", filetypes = { "python" } },
	{ exe = "pylama", filetypes = { "python" } },
	-- { exe = "flake8", filetypes = { "python" } },
	-- { exe = "pyproject_flake8", filetypes = { "python" } },
	{ exe = "golangci-lint", filetypes = { "go" } },
	{ name = "codespell" },
	{ name = "terraform_validate" },
	{ name = "curlylint" },
	-- { name = "selene" },
	{ name = "shellcheck", args = { "--severity", "info" } },
})

code_actions.setup({
	{ name = "proselint" },
	{ name = "refactoring" },
	{ name = "shellcheck" },
})

-- completion.setup({
-- 	{ name = "luasnip" },
-- 	{ name = "spell" },
-- 	{ name = "tags" },
-- })

formatters.setup({
	{ exe = "stylua", filetypes = { "lua" } },

	{ exe = "black", filetypes = { "python" } },
	-- { exe = "blue", filetypes = { "python" } },
	-- { exe = "pyink", filetypes = { "python" } },
	{ exe = "ruff", filetypes = { "python" } },
	-- { exe = "isort", filetypes = { "python" } },
	{ exe = "reorder_python_imports", filetypes = { "python" } },
	-- { exe = "djlint", filetypes = { "django", "jinja.html", "htmldjango" } },
	-- { exe = "djhtml", filetypes = { "django", "jinja.html", "htmldjango" } },

	{ exe = "goimports", filetypes = { "go" } },
	{ exe = "gofumpt", filetypes = { "go" } },

	{ exe = "rustfmt", filetypes = { "rust" } },
})

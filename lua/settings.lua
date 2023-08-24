------------------------------------------------------
-- Settings
------------------------------------------------------
lvim.leader = ","
lvim.transparent_window = false
lvim.colorscheme = "tokyonight-storm"
-- Python base dependencies
vim.g.python3_host_prog = "~/.pyenv/versions/py3nvim/bin/python"
-- Folding
vim.o.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- enamble matchup on treesitter
lvim.builtin.treesitter.matchup.enable = true
-- disable bufferline plugin
lvim.builtin.bufferline.active = false

-- disable lint errors on .env files
-- table.insert(lvim.lsp.automatic_configuration.skipped_filetypes, "env")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>hl")

-- Don't auto commenting new lines
vim.cmd([[ au BufEnter * set fo-=c fo-=r fo-=o ]])

-- Open file at same location where it was opened last time
vim.cmd(
	[[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
)

-- Autom. read file when changed outside of Vim
vim.o.autoread = true
vim.cmd([[ au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif ]])
vim.cmd([[ au FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None ]])

-- Enable wrap
vim.o.wrap = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>hl")

-- Take indent for new line from previous line
vim.o.autoindent = true
vim.o.smartindent = true

-- Wrap long lines at a blank
vim.o.linebreak = true

-- Incremental live completion
vim.o.inccommand = "nosplit"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Do not save when switching buffers
-- vim.o.hidden = true

-- Use swapfiles
vim.o.swapfile = true

-- Save undo history
vim.o.undofile = true
vim.o.undolevels = 1000

-- Faster scrolling
vim.o.lazyredraw = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Number of command-lines that are remembered
vim.o.history = 10000

-- Autom. save file before some action
vim.o.autowrite = true

-- Keep backup file after overwriting a file
vim.o.backup = true

-- Make a backup before overwriting a file
vim.o.writebackup = false

-- Ignore case when completing file names and directories.
vim.o.wildignorecase = true

-- Set directories for backup/swap/undo files and create them if necessary
local Path = require("plenary.path")

local swapdir = Path:new(Path.path.home .. "/.cache/nvim/swap/")
if not swapdir:exists() then
	swapdir:mkdir()
end
vim.o.directory = tostring(swapdir)

local backupdir = Path:new(Path.path.home .. "/.cache/nvim/backup/")
if not backupdir:exists() then
	backupdir:mkdir()
end
vim.o.backupdir = tostring(backupdir)

local undodir = Path:new(Path.path.home .. "/.cache/nvim/undo/")
if not undodir:exists() then
	undodir:mkdir()
end
vim.o.undodir = tostring(undodir)

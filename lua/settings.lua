------------------------------------------------------
-- Settings
------------------------------------------------------
lvim.leader = ","
lvim.transparent_window = false
lvim.format_on_save.enabled = false

-- Python base dependencies
vim.g.python3_host_prog = "~/.pyenv/versions/py3nvim/bin/python"
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append("<>hl")
-- Don't auto commenting new lines
vim.cmd([[ au BufEnter * set fo-=c fo-=r fo-=o ]])
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
-- Autom. read file when changed outside of Vim
vim.o.autoread = true
-- Open file at same location where it was opened last time
vim.cmd(
  [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
)

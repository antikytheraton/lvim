------------------------------------------------------
-- Commands
------------------------------------------------------

-- delete trailing spaces
vim.cmd([[ command DeleteTrailingSpaces %s/\\s\\+$//e<cr> ]])
-- UNIX - DOS formatting commands
vim.cmd([[ command Dos2Unix !dos2unix %<cr> ]])
vim.cmd([[ command Unix2Dos !unix2dos %<cr> ]])
-- Format JSON using jq
vim.cmd([[ command JQ %!jq . <cr> ]])
-- Apply reorder-python-imports formatter
vim.cmd([[ command ReorderPythonImports !reorder-python-imports % <cr>]])
-- Run Make Test
vim.cmd([[ command PyTest AsyncRun -mode=term -pos=tmux -rows=10 make -f Makefile.back pytest<cr> ]])
-- Session
vim.cmd([[ command SessionLoad lua require('persistence').load()<cr> ]])
-- VENN
vim.cmd([[ command ToggleVENN lua require('config.venn').toggle()<cr> ]])

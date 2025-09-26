-- Windows PATH contain nothing useful to neovim and it's very slow to find command in them.
-- So we remove them here
local paths = vim.split(vim.env.PATH, ':', { plain = true })
local filtered = {}
for _, p in ipairs(paths) do
	if not vim.startswith(p, "/mnt/c") then
		table.insert(filtered, p)
	end
end
vim.env.PATH = table.concat(filtered, ':')

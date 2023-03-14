vim.o.number = true
vim.o.relativenumber = true

vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = "a"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.scrolloff = 10
vim.o.updatetime = 100
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.laststatus = 3
vim.o.cmdheight = 0
vim.o.winbar = "%{%luaeval('require(\"util.winbar\").set_winbar()')%}"

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.spelllang = "en_us"

vim.o.swapfile = false

-- nvim-ufo
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

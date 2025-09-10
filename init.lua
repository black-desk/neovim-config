-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

require("black_desk.python").ensure_python3_provider()

local config_path = vim.fn.stdpath('config')
vim.cmd("source " .. config_path .. "/vimrc")

-- =============================================================================
-- Setup lazy.nvim
-- =============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

if not vim.uv.fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        utils.shell.run_command(
                {
                        "git", "clone", "--filter=blob:none", "--branch=stable",
                        lazyrepo, lazypath,
                },
                "clone lazy.nvim", true
        )
end

require("lazy").setup({
        spec = { import = "black_desk.plugins" },
        install = {
                missing = true,
                colorscheme = { "habamax" },
        },
})


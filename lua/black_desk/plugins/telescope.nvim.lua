-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

-- https://github.com/nvim-telescope/telescope.nvim

-- Description:
-- telescope.nvim is a highly extendable fuzzy finder over lists.
-- Built on the latest awesome features from neovim core.
-- Telescope is centered around modularity, allowing for easy customization.

local function config()
	local documents_dir = os.getenv("HOME").."/Documents"
	local handle = io.popen("xdg-user-dir DOCUMENTS")
	if handle ~= nil then
		documents_dir = handle:read("*a")
		handle:close()
		documents_dir = documents_dir:gsub("%s+$", "")
	end

        local actions = require("telescope.actions")
        require('telescope').setup({
                defaults = {
                        layout_strategy = "vertical",
                        layout_config = { vertical = { width = 0.9 } },
                        mappings = {
                                i = {
                                        ["<C-j>"] = actions.move_selection_next,
                                        ["<C-k>"] = actions.move_selection_previous,
                                },
                                n = {
                                        ["<C-j>"] = actions.cycle_history_next,
                                        ["<C-k>"] = actions.cycle_history_prev,
                                }
                        }
                },
                extensions = {
                        ["ui-select"] = {
                                require("telescope.themes").get_dropdown {},
			},
                        project = {
                                base_dirs = { {
					documents_dir .. "/workspace/repositories",
					max_depth = 2,
                                } }
                        },


                }
        })

        require("telescope").load_extension("ui-select")
        require("telescope").load_extension('project')
	require("telescope").load_extension('frecency')

        vim.api.nvim_create_autocmd("LspAttach", {
                callback = function()
                        local map = function(lhs, rhs, desc)
                                vim.keymap.set('n', lhs, rhs, {
                                        silent = true,
                                        buffer = true,
                                        desc = desc,
                                })
                        end

                        local builtin = require('telescope.builtin')

                        map("<space>H", builtin.jumplist, "Telescope jumplist")
                        map("<space>M", builtin.marks, "Telescope marks")
                        map("<space>s", builtin.lsp_document_symbols, "Telescope LSP document symbols")
                        map("gd", builtin.lsp_definitions, "Telescope LSP definitions")
                        map("gi", builtin.lsp_implementations, "Telescope LSP implementations")
                        map("gr", builtin.lsp_references, "Telescope LSP references")
                        map("gy", builtin.lsp_type_definitions, "Telescope LSP type definitions")
                end,
        })
end

return { {
        'nvim-telescope/telescope.nvim',
        dependencies = {
                'nvim-lua/plenary.nvim',
        },
        keys = { {
		"tR",
		function() require('telescope.builtin').grep_string() end,
		desc = "TELE:: search in files",
		remap = false

	}, {
		"tr",
		function() require('telescope.builtin').live_grep() end,
		desc = "TELE:: search in files",
		remap = false

	}, {
		"<leader>e",
		function()
                        local builtin = require('telescope.builtin')
			builtin.find_files( {
				no_ignore = true,
				hidden = true,
			})
		end,
		desc = "Telescope find_files",
		remap = false
	}, {
		"<leader>p",
		function()
			require('telescope').
			    extensions.
			    project.
			    project({
				    initial_mode = "normal"
			    })
		end,
		desc = "Telescope projects browser",
		remap = false
	} },
        cmd = { 'Telescope' },
        event = "LspAttach",
        config = config,
}, 
	'nvim-telescope/telescope-ui-select.nvim',
	'nvim-telescope/telescope-project.nvim',
	'nvim-telescope/telescope-frecency.nvim',
} 

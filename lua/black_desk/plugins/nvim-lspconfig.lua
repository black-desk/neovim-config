-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

-- https://github.com/neovim/nvim-lspconfig

-- Description:
-- lsp configs for neovim builtin lsp

-- NOTE: In config() we are not allow to call other local functions, which
-- leads to a error. So we have to put all local functions at the start of
-- config()

local function config()
	local servers = {
		bashls = {},
		clangd = {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--completion-style=detailed",
				"--enable-config",
				"--offset-encoding=utf-16",
				"-j=8",
			},
			root_dir = require("lspconfig.util").root_pattern(
				"build/compile_commands.json",
				"compile_commands.json",
				".git"),
		},
		cmake = {},
		efm = {
			filetypes = require('efmls-configs.defaults').languages(),
			settings = {
				rootMarkers = { 'build/compile_commands.json', ".git" },
				languages = {
					markdown = { require('efmls-configs.formatters.prettier_d') },
					python = { require('efmls-configs.formatters.black') },
				},
			},
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
			},
		},
		eslint = {},
		gopls = {},
		hls = {},
		jsonls = {},
		lemminx = {},
		lua_ls = {},
		marksman = {},
		perlnavigator = {},
		pyright = {
			settings = {
				python = {
					pythonPath = require("black_desk.python").find_python(),
				}
			}
		},
		rust_analyzer = {},
		taplo = {},
		texlab = {},
		tinymist = {},
		ts_ls = {},
		vimls = {},
		yamlls = {},
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true
	}
	capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

	for lsp, cfg in pairs(servers) do
		if next(cfg) ~= nil then
			vim.lsp.config(lsp, cfg)
		end
		vim.lsp.enable(lsp)
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local set_keymap = function(lhs, rhs, desc)
				vim.keymap.set(
					"n", lhs, rhs,
					{
						buffer = args.buf,
						desc = desc
					}
				)
			end
			set_keymap("K", vim.lsp.buf.hover, "do hover")
			set_keymap("<C-k>", vim.lsp.buf.signature_help, "show signature help")
			set_keymap("<space>rn", vim.lsp.buf.rename, "rename")
			set_keymap("<space>f", function()
				vim.lsp.buf.format({
					filter = function(client)
						return client.name ~= "tsserver"
					end
				})
			end, "format document")
			set_keymap("<space>E", vim.diagnostic.open_float, "show float diagnostic")
			set_keymap("<space>a", vim.lsp.buf.code_action, "show code action")

			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client == nil then
				return
			end
		end
	})
end

return {
	'neovim/nvim-lspconfig',
	config = config,
	dependencies = {
		'kevinhwang91/nvim-ufo',
		'creativenull/efmls-configs-nvim',
	}
}

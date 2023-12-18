local lsp_zero = require("lsp-zero")

local function allow_format(servers)
	return function(client)
		return vim.tbl_contains(servers, client.name)
	end
end
lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({ buffer = bufnr })
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })

	vim.lsp.buf.format({
		filter = allow_format({ "lemminx" }),
		async = true,
		timeout_ms = 10000,
		servers = {
			["lemminx"] = { "xml" },
		},
	})
	-- end, opts)
end)

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require("lspconfig").lua_ls.setup(lua_opts)
		end,
	},
})

-- lsp_zero.format_mapping('gq', {
--     format_opts = {
--         async = false,
--         timeout_ms = 10000,
--     },
--     servers = {
--         ['tsserver'] = { 'javascript', 'typescript' },
--         ['lemminx'] = { 'xml', 'bpt' },
--         ['rust_analyzer'] = { 'rust' },
--     }
-- })

local cmp = require("cmp")
local cmp_format = lsp_zero.cmp_format()

cmp.setup({
	formatting = cmp_format,
	mapping = cmp.mapping.preset.insert({
		-- scroll up and down the documentation window
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	}),
})

-- local rust_tools = require("rust-tools")
-- 
-- rust_tools.setup({
-- 	server = {
-- 		on_attach = function(client, bufnr)
-- 			vim.keymap.set("n", "<leader>caa", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
-- 		end,
-- 	},
-- })

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
end)

require("mason").setup({})
require("mason-lspconfig").setup({
<<<<<<< Updated upstream
    ensure_installed = { "clangd", "lua_ls", "pylsp" },  -- Ensure clangd is installed
=======
    ensure_installed = { "clangd" },  -- Ensure clangd is installed
>>>>>>> Stashed changes
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
        clangd = function()
            require('lspconfig').clangd.setup {
<<<<<<< Updated upstream
                cmd = { 'clangd' },
                -- , '--query-driver', '/home/moh/dev/ngfw-draft/.builds/fwaas_qemu_x86_64_release/host/bin/x86_64-buildroot-linux-gnu-g++' },
=======
                cmd = { 'clangd', '--query-driver', '/home/moh/dev/ngfw/.builds/fwaas-vm-release/x86_64-buildroot-linux-gnu-g++' },
>>>>>>> Stashed changes
                init_options = {
                    clangdFileStatus = true,
                    clangdSemanticHighlighting = true,
                },
<<<<<<< Updated upstream
                filetypes = { 'c', 'cpp', 'cxx', 'cc', 'hpp' },
=======
                filetypes = { 'c', 'cpp', 'cxx', 'cc' },
>>>>>>> Stashed changes
            }
        end,
    },
})

local cmp = require("cmp")
local cmp_format = lsp_zero.cmp_format()

cmp.setup({
    formatting = cmp_format,
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
})


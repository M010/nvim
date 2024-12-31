
vim.opt.langmap = "йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ.\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>/?"
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, { desc = "call formater" })

-- TODO: use copilot
-- toggle showing wornings 
local show_warnings = false

function ToggleWarnShow()
  show_warnings = not show_warnings

  if show_warnings then
    vim.diagnostic.config({
            virtual_text = {
                severity = {min = vim.diagnostic.severity.HINT}
            },
--            signs = {
--                severity = vim.diagnostic.severity.INFO,
--            },
--            underline = {
--                severity = vim.diagnostic.severity.INFO,
--            },
        })
        print("Show Warnings")
  else
    vim.diagnostic.config({
            virtual_text = {
                severity = vim.diagnostic.severity.ERROR,
            },
        })
        print("Show only errors")
  end
end

-- Перемещение между ошибками в lsp 
vim.keymap.set("n", "<leader>]", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>[", vim.diagnostic.goto_prev)

vim.keymap.set("n", "<leader>tw", ToggleWarnShow)

-- TODO remove if unused
function Try()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end

vim.keymap.set("n", "<leader>tr", Try)


-- Cpp remaps

-- Keybinding to build the project
vim.api.nvim_set_keymap("n", "<leader>cb", ":CMakeBuild<CR>", { noremap = true, silent = true })

-- Keybinding to debug the selected target
vim.api.nvim_set_keymap("n", "<leader>cd", ":CMakeSelectTarget<CR>:GdbStart gdb ./build/<C-R>=expand('%:t:r')<CR><CR>", { noremap = true, silent = true })

local cmake = require("cmake-tools")

-- Function to start debugging the current CMake project
local function start_debugging()
  -- Check if the current project is a CMake project
  if not cmake.is_cmake_project() then
    print("Not a CMake project!")
    return
  end

  -- Ensure the project has been configured
  if not cmake.has_cmake_preset() then
    print("No CMake presets found! Please configure the project first.")
    return
  end

  -- Get the launch target path
  local target_path = cmake.get_launch_target_path()
  if not target_path or target_path == "" then
    print("No launch target found! Please set a launch target.")
    return
  end

  -- Get the launch arguments (if any)
  local launch_args = cmake.get_launch_args() or ""

  -- Start nvim-gdb with the target and arguments
  local gdb_command = string.format("GdbStart gdb --args %s %s", target_path, launch_args)
  vim.cmd(gdb_command)
end

-- Keybinding to start debugging
vim.keymap.set("n", "<leader>dd", start_debugging, { noremap = true, silent = true })



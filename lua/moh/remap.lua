
vim.opt.langmap = "йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ.\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>/?"
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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

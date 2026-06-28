-- Sakura Season · Neovim
-- Soft cherry-blossom palette with warm contrast and gentle focus states.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.numberwidth = 4
opt.wrap = false
opt.scrolloff = 6
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10
opt.laststatus = 3
opt.showmode = false
opt.cmdheight = 1
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " " }
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.undofile = true
opt.mouse = "a"

local palette = {
  bg = "#121212",
  bg_soft = "#1a1620",
  bg_muted = "#1e1e30",
  panel = "#2a1a28",
  panel_alt = "#2a1520",
  border = "#4a4050",
  border_soft = "#d4a8b8",
  fg = "#f0e4e8",
  fg_muted = "#d0c0c8",
  comment = "#a098a0",
  accent = "#f0a0b0",
  accent_soft = "#d4a8b8",
  inactive = "#7b7b9e",
  red = "#d44a5a",
  green = "#a0d4a8",
  yellow = "#e8d8a8",
  blue = "#a8b0d8",
  magenta = "#d8a8c8",
  cyan = "#a8d8d0",
}

vim.o.background = "dark"

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "sakura-season"

local set = vim.api.nvim_set_hl
local function hi(group, spec)
  set(0, group, spec)
end

hi("Normal", { fg = palette.fg, bg = palette.bg })
hi("NormalNC", { fg = palette.fg_muted, bg = palette.bg })
hi("NormalFloat", { fg = palette.fg, bg = palette.bg_soft })
hi("FloatBorder", { fg = palette.accent_soft, bg = palette.bg_soft })
hi("FloatTitle", { fg = palette.accent, bg = palette.bg_soft, bold = true })
hi("ColorColumn", { bg = palette.bg_soft })
hi("CursorLine", { bg = palette.bg_soft })
hi("CursorLineNr", { fg = palette.accent, bg = palette.bg_soft, bold = true })
hi("LineNr", { fg = palette.inactive, bg = palette.bg })
hi("CursorColumn", { bg = palette.bg_soft })
hi("SignColumn", { fg = palette.fg_muted, bg = palette.bg })
hi("VertSplit", { fg = palette.border, bg = palette.bg })
hi("WinSeparator", { fg = palette.border, bg = palette.bg })
hi("StatusLine", { fg = palette.fg, bg = palette.panel })
hi("StatusLineNC", { fg = palette.comment, bg = palette.bg_soft })
hi("TabLine", { fg = palette.fg_muted, bg = palette.bg_soft })
hi("TabLineFill", { bg = palette.bg })
hi("TabLineSel", { fg = palette.bg, bg = palette.accent, bold = true })
hi("Pmenu", { fg = palette.fg, bg = palette.bg_soft })
hi("PmenuSel", { fg = palette.bg, bg = palette.accent, bold = true })
hi("PmenuSbar", { bg = palette.panel })
hi("PmenuThumb", { bg = palette.accent_soft })
hi("Visual", { bg = palette.panel })
hi("Search", { fg = palette.bg, bg = palette.yellow })
hi("IncSearch", { fg = palette.bg, bg = palette.accent })
hi("CurSearch", { fg = palette.bg, bg = palette.accent })
hi("MatchParen", { fg = palette.accent, bg = palette.panel_alt, bold = true })
hi("Directory", { fg = palette.accent, bold = true })
hi("Title", { fg = palette.accent, bold = true })
hi("ErrorMsg", { fg = palette.red, bold = true })
hi("WarningMsg", { fg = palette.yellow, bold = true })
hi("MoreMsg", { fg = palette.green, bold = true })
hi("ModeMsg", { fg = palette.accent_soft, bold = true })
hi("Question", { fg = palette.green, bold = true })
hi("NonText", { fg = palette.border })
hi("Whitespace", { fg = palette.border })
hi("SpecialKey", { fg = palette.border_soft })
hi("Conceal", { fg = palette.inactive })
hi("Comment", { fg = palette.comment, italic = true })
hi("Constant", { fg = palette.accent_soft })
hi("String", { fg = palette.green })
hi("Character", { fg = palette.green })
hi("Number", { fg = palette.yellow })
hi("Boolean", { fg = palette.yellow, bold = true })
hi("Float", { fg = palette.yellow })
hi("Identifier", { fg = palette.fg })
hi("Function", { fg = palette.accent })
hi("Statement", { fg = palette.accent, bold = true })
hi("Conditional", { fg = palette.magenta, bold = true })
hi("Repeat", { fg = palette.magenta, bold = true })
hi("Label", { fg = palette.accent_soft })
hi("Operator", { fg = palette.accent_soft })
hi("Keyword", { fg = palette.magenta, italic = true })
hi("Exception", { fg = palette.red, bold = true })
hi("PreProc", { fg = palette.blue })
hi("Include", { fg = palette.blue })
hi("Define", { fg = palette.magenta })
hi("Macro", { fg = palette.magenta })
hi("PreCondit", { fg = palette.blue })
hi("Type", { fg = palette.blue })
hi("StorageClass", { fg = palette.blue, italic = true })
hi("Structure", { fg = palette.blue })
hi("Typedef", { fg = palette.blue, bold = true })
hi("Special", { fg = palette.cyan })
hi("SpecialChar", { fg = palette.cyan })
hi("Tag", { fg = palette.accent })
hi("Delimiter", { fg = palette.fg_muted })
hi("SpecialComment", { fg = palette.comment, italic = true })
hi("Debug", { fg = palette.red })
hi("Underlined", { fg = palette.blue, underline = true })
hi("Bold", { bold = true })
hi("Italic", { italic = true })
hi("Todo", { fg = palette.bg, bg = palette.accent_soft, bold = true })
hi("Error", { fg = palette.red, bg = palette.bg })
hi("DiffAdd", { fg = palette.green, bg = "#1b241f" })
hi("DiffChange", { fg = palette.blue, bg = "#1a2030" })
hi("DiffDelete", { fg = palette.red, bg = "#2a171c" })
hi("DiffText", { fg = palette.bg, bg = palette.accent_soft, bold = true })
hi("DiagnosticError", { fg = palette.red })
hi("DiagnosticWarn", { fg = palette.yellow })
hi("DiagnosticInfo", { fg = palette.blue })
hi("DiagnosticHint", { fg = palette.cyan })
hi("DiagnosticOk", { fg = palette.green })
hi("DiagnosticUnderlineError", { undercurl = true, sp = palette.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = palette.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = palette.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = palette.cyan })
hi("GitSignsAdd", { fg = palette.green })
hi("GitSignsChange", { fg = palette.blue })
hi("GitSignsDelete", { fg = palette.red })

-- Let Alacritty + Niri provide the acrylic background.
for _, group in ipairs({
  "Normal",
  "NormalNC",
  "EndOfBuffer",
  "LineNr",
  "SignColumn",
  "FoldColumn",
  "WinSeparator",
  "VertSplit",
  "StatusLine",
  "StatusLineNC",
  "TabLine",
  "TabLineFill",
}) do
  local ok, current = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
  if ok then
    current.bg = "NONE"
    current.ctermbg = "NONE"
    vim.api.nvim_set_hl(0, group, current)
  end
end

vim.g.terminal_color_0 = palette.bg_soft
vim.g.terminal_color_1 = palette.red
vim.g.terminal_color_2 = palette.green
vim.g.terminal_color_3 = palette.yellow
vim.g.terminal_color_4 = "#9098c0"
vim.g.terminal_color_5 = "#c090b0"
vim.g.terminal_color_6 = "#90c0b8"
vim.g.terminal_color_7 = palette.fg_muted
vim.g.terminal_color_8 = palette.border
vim.g.terminal_color_9 = "#e87088"
vim.g.terminal_color_10 = "#b8e4c0"
vim.g.terminal_color_11 = palette.yellow
vim.g.terminal_color_12 = palette.blue
vim.g.terminal_color_13 = palette.magenta
vim.g.terminal_color_14 = palette.cyan
vim.g.terminal_color_15 = palette.fg

vim.opt.statusline = table.concat({
  "%#StatusLine#",
  " ",
  "%f",
  "%m%r",
  "%=",
  "%#CursorLineNr#",
  " %y ",
  "%#StatusLine#",
  "%l:%c ",
  "%p%% ",
})

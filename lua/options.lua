local opts = {
  number = true,
  relativenumber = true,
  cmdheight = 1,
  cursorline = true,
  signcolumn = "yes", -- number: for thinner lines
  laststatus = 2,
  showmode = false,

  conceallevel = 0,

  clipboard = "unnamedplus",
  belloff = "all",

  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  shiftround = true, -- always indent by multiple of shiftwidth
  expandtab = true,  -- Always use spaces instead of tabs
  scrolloff = 5,     -- Start scrolling x lines before edge of view port

  splitbelow = true, -- Open horizontal splits below the current one
  splitright = true, -- Open vertical splits right of the current one
  autoindent = true,

  fileencoding = "utf-8",
  smarttab = true,
  smartindent = true,
  hidden = true, -- allows you to hide buffers with unsaved changes without being prompted
  wrap = false,

  mouse = "a",  -- Enables mouse functionality
  list = false, -- Show white spaces

  -- inccommand = "split", -- Line preview of :s results
  incsearch = true,     -- Do incremental search
  ignorecase = true,    -- Ignore case in search

  termguicolors = true, -- Use 24bit colors
  synmaxcol = 200,      -- Don't bother syntax highlighting long lines
  completeopt = "menuone,noselect,noinsert",

  backup = false,                -- Don't use generated backup files
  swapfile = false,              -- Don't create swapfiles
  writebackup = false,           -- Don't write a backup file

  spelllang = { "en", "cjk" },   -- Enable spelling for English
  spellsuggest = { "best", 10 }, -- Show x the best matching results
  spell = true,                  -- Enable spell checker
  spellcapcheck = "",            -- Don't check for capital letters
}

opts.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
  vert = "▎",
}

opts.listchars = {
  nbsp = "⦸",
  extends = "»",
  precedes = "«",
  trail = "•",
}

opts.shortmess = vim.opt.shortmess
    + "A" -- Ignore annoying swapfile messages
    + "c" -- Don't show matching messages
    + "o" -- Overwrite file-written message
    + "O" -- File-read message overrates previous
    + "s" -- Don't give "search hit BOTTOM, continuing at TOP"
    + "t" -- Truncate file messages at start
    + "T" -- Truncate non-file messages in middle
    + "W" -- Don't echo '[w]/[written]' when writing

-- Influence how Vim formats text (:help fo-table)
opts.formatoptions = vim.opt.formatoptions
    - "a" -- Don't autoformat
    - "t" -- Don't autoformat my code, have linter's for that
    + "l" -- Long lines are not broken up
    + "j" -- Remove comment leader when joining comments
    + "r" -- Continue comment with enter
    - "o" -- Don't continue comment with w/ o and o
    + "n" -- Smart auto indenting inside numbered lists

vim.opt.mousemoveevent = true

if vim.fn.has("win32") == 1 then
  if vim.fn.executable("pwsh") then
    opts.shell = "pwsh"
  else
    opts.shell = "powershell"
  end
  opts.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
      .. "[Console]::InputEncoding=[Console]::OutputEncoding="
      .. "[Systeopts.Text.Encoding]::UTF8;"
  opts.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  opts.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  opts.shellquote = ""
  opts.shellxquote = ""
end

for k, v in pairs(opts) do
  vim.opt[k] = v
end

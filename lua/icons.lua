local M = {}

M.lualine_icon = "󰈸"

M.loading = {
  completed = "",
  uncompleted = "",
  loading_spinner = {
    "󰪞",
    "󰪟",
    "󰪠",
    "󰪡",
    "󰪢",
    "󰪣",
    "󰪤",
    "󰪥",
  },
  downloading = "",
}

M.arrow = {
  left = "",
  right = "",
  up = "",
  down = "",
}

M.cmdline = {
  cmdline = " ",
  filter = "󰈲 ",
  filter_highlighted = "󱃥 ",
  search = " ",
  lua = " ",
  python = "󰌠 ",
  help = "? ",
}

M.task = {
  checked = "",
  unchecked = "",
  dot_checked = "",
  dot_unchecked = "",
}

M.list = {
  "●",
  M.arrow.right,
  "★",
  "‒",
}

M.mason = {
  package_installed = M.loading.completed,
  package_pending = M.loading.downloading,
  package_uninstalled = M.loading.uncompleted,
}

M.seporators = {
  horizontal = {
    segmented = "---",
    connected = "───",
  },
  vertical = {
    thick = "▎",
    thin = "▏",
    centered = "│",
  },
}

M.barbar = {
  separator = { left = M.seporators.vertical.thick, right = "" },
  close = M.task.unchecked,
  modified = M.task.dot_unchecked,
  present = "default", -- default', 'powerline', or 'slanted'
}

M.dap = {
  DapBreakpoint = { text = "", texthl = "DiagnosticSignError" },
  DapBreakpointCondition = { text = "", texthl = "DiagnosticSignError" },
  DapLogPoint = { text = "󰹕", texthl = "DiagnosticSignInfo" },
  DapStopped = { text = M.arrow.right, texthl = "Operator" },
  DapBreakpointRejected = { text = "", texthl = "Comment" },
}

M.dapui = {
  debugging_controls = {
    disconnect = "",
    pause = "",
    play = "",
    run_last = "",
    step_back = "",
    step_into = "",
    step_out = "",
    step_over = "",
    terminate = "",
  },
  expanding_controls = {
    collapsed = "",
    current_frame = "",
    expanded = "",
  },
}

M.lazy = {
  cmd = "",
  config = "",
  event = "",
  ft = "󰈙",
  init = "",
  import = "",
  keys = "󰌌",
  lazy = "󰂠",
  loaded = M.loading.completed,
  not_loaded = M.loading.uncompleted,
  plugin = "",
  runtime = "",
  require = "󰢱",
  source = "󰅱",
  start = "",
  task = M.task.checked,
  list = M.list,
}

M.diagnostics = {
  debug = " ",
  error = " ",
  -- warn = " ",
  warn = " ",
  info = " ",
  hint = " ",
  other = {
    bug = " ",
    todo = " ",
    warn = "󰀪 ",
    hack = " ",
    note = "󱞂 ",
    perf = "󱫍 ",
    test = " ",
  },
}

M.gitsigns = {
  add = { text = M.seporators.vertical.centered },
  change = { text = M.seporators.vertical.centered },
  delete = { text = "_" },
  topdelete = { text = "‾" },
  changedelete = { text = M.seporators.vertical.centered },
  untracked = { text = M.seporators.vertical.centered },
}

M.git = {
  modified = "",
  deleted = "󰧧",
  added = "",
  renamed = "",
  copied = "»",
  type_change = "",
  untracked = "󱟂",
}

M.nvim_tree_glyphs = {
  default = "󰈙",
  symlink = "",
  bookmark = "",
  folder = { -- nf-md-folder
    arrow_closed = "",
    arrow_open = "",
    default = "󰉋",
    open = "󰝰",
    empty = "󰉖",
    empty_open = "󰷏",
    symlink = "󰉕",
    symlink_open = "󰉕",
  },
  git = {
    unstaged = M.git.modified,
    staged = "»",
    unmerged = "󰘭",
    renamed = M.git.renamed,
    untracked = M.git.untracked,
    deleted = M.git.deleted,
    ignored = "",
  },
}

M.whichkey = {
  breadcrumb = "»",
  separator = M.arrow.right .. " ",
  group = "",
}

M.kind = {
  Text = "󱌯",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "󰯠",
  Unit = "",
  Value = "",
  Enum = "",
  EnumMember = "",
  Keyword = "",
  Snippet = "",
  Color = "♥",
  File = "󰧮",
  Reference = "",
  Folder = "󰉖",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
  Parameter = "󰘦",
  Unknown = "?",
  Number = "",
  Boolean = "󰨚",
  Character = "󱌯",
  String = "",
  Codeium = "󱙺",
  Tabnine = "󱙺",
  Copilot = "",
}

return M

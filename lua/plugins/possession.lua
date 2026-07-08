return {
  "jedrzejboczar/possession.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  -- cmd = { "ProjectSave", "ProjectLoad", "ProjectDelete", "ProjectList" },
  cmd = { "ProjectSave", "ProjectList" },
  config = function()
    require("possession").setup({
      plugins = {
        nvim_tree = false,
        neo_tree = false,
        symbols_outline = false,
        outline = false,
        tabby = false,
        dap = false,
        dapui = false,
        neotest = false,
        kulala = false,
        delete_buffers = true,
        stop_lsp_clients = true,
      },
      autosave = {
        current = true,
      },
      commands = {
        save = "ProjectSave",
        -- load = "ProjectLoad",
        -- delete = "ProjectDelete",
        -- list = "ProjectList",
      },
      -- list = {
      -- mappings = {
      -- delete = { n = '<c-t>', i = '<c-t>' },
      --     save   = { n = '<c-x>', i = '<c-x>' },
      --     load   = { n = '<c-v>', i = '<c-v>' },
      --     rename = { n = '<c-r>', i = '<c-r>' },
      --     grep   = { n = '<c-g>', i = '<c-g>' },
      --     find   = { n = '<c-f>', i = '<c-f>' },
      --   },
      -- },
    })

    local telescope = require("telescope")
    telescope.load_extension("possession")

    vim.api.nvim_create_user_command("ProjectList", function()
      telescope.extensions.possession.list()
    end, { desc = "Open project/session from list" })
  end,
}

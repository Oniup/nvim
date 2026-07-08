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
      autosave = {
        current = true,
      },
      commands = {
        save = "ProjectSave",
        -- load = "ProjectLoad",
        -- delete = "ProjectDelete",
        -- list = "ProjectList",
      },
    })

    local telescope = require("telescope")
    telescope.load_extension("possession")

    vim.api.nvim_create_user_command("ProjectList", function()
      telescope.extensions.possession.list()
    end, { desc = "Open project/session from list" })
  end,
}

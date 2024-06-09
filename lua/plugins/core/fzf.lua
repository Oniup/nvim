return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "web-devicons",
    },
    cmd = { "FzfLua" },
    config = function()
        local ui = require("core.ui")
        local icons = require("core.icons")
        local actions = require("fzf-lua.actions")

        require("fzf-lua").setup({
            "telescope",
            fzf_opts = {
                ["--layout"] = "reverse",
            },
            winopts = ui.fzf_themes.default,
            keymap = {
                -- Only section that uses vim mapping options
                builtin = {
                    ["<F1>"] = "toggle-help",
                    ["<F2>"] = "toggle-preview",

                    ["<C-e>"] = "preview-page-down",
                    ["<C-y>"] = "preview-page-up",
                },
                fzf = {
                    ["ctrl-q"] = "abort",
                    ["ctrl-d"] = "half-page-down",
                    ["ctrl-u"] = "half-page-up",
                    -- Only valid with fzf previewers (bat/cat/git/etc)
                    ["ctrl-e"] = "preview-page-down",
                    ["ctrl-y"] = "preview-page-up",
                },
            },
            actions = {
                files = {
                    ["default"] = actions.file_edit_or_qf,
                    ["ctrl-s"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                },
                buffers = {
                    ["default"] = actions.buf_edit,
                    ["ctrl-s"] = actions.buf_split,
                    ["ctrl-v"] = actions.buf_vsplit,
                },
            },
            previewers = {
                builtin = {
                    treesitter = { enable = true },
                    extensions = {
                        ["png"] = { "viu", "-b" },
                        ["svg"] = { "viu", "-b" },
                        ["jpg"] = { "viu", "-b" },
                    },
                },
            },
            files = {
                cwd_prompt = false,
                winopts = ui.fzf_themes.enable_preview,
                actions = {
                    ["ctrl-g"] = { actions.toggle_ignore },
                },
            },
            grep = {
                winopts = ui.fzf_themes.enable_preview,
                actions = {
                    ["ctrl-g"] = { actions.toggle_ignore },
                },
            },
            git = {
                status = {
                    winopts = ui.fzf_themes.enable_preview,
                    actions = {
                        ["ctrl-l"] = { fn = actions.git_unstage, reload = true },
                        ["ctrl-h"] = { fn = actions.git_stage, reload = true },
                        ["ctrl-r"] = { fn = actions.git_reset, reload = true },
                        ["ctrl-s"] = { fn = actions.git_stage_unstage, reload = true },
                    },
                },
                branches = {
                    winopts = ui.fzf_themes.enable_preview,
                    actions = {
                        ["default"] = actions.git_switch,
                        ["ctrl-d"] = { fn = actions.git_branch_del, reload = true },
                        ["ctrl-a"] = {
                            fn = actions.git_branch_add,
                            field_index = "{q}",
                            reload = true,
                        },
                    },
                    cmd_add = { "git", "branch" },
                    cmd_del = { "git", "branch", "--delete" },
                },
                icons = {
                    ["M"] = { icon = icons.git.modified, color = "yellow" },
                    ["D"] = { icon = icons.git.deleted, color = "red" },
                    ["A"] = { icon = icons.git.added, color = "green" },
                    ["R"] = { icon = icons.git.renamed, color = "yellow" },
                    ["C"] = { icon = icons.git.copied, color = "yellow" },
                    ["T"] = { icon = icons.git.type_change, color = "magenta" },
                    ["?"] = { icon = icons.git.untracked, color = "magenta" },
                },
            },
            helptags = {
                winopts = ui.fzf_themes.enable_preview,
            },
            changes = {
                winopts = ui.fzf_themes.enable_preview,
            },
            lsp = {
                winopts = ui.fzf_themes.enable_preview,
                symbols = {
                    symbol_style = 2,
                    symbol_icons = icons.kind,
                },
                code_actions = {
                    winopts = ui.fzf_themes.enable_preview,
                    actions = {
                        ["default"] = actions.code_action,
                        ["ctrl-y"] = { fn = actions.code_action_yank, exec_silent = true },
                    },
                },
                diagnostics = {
                    winopts = ui.fzf_themes.enable_preview,
                    signs = {
                        ["Error"] = { text = icons.diagnostics.error },
                        ["Warn"] = { text = icons.diagnostics.warn },
                        ["Info"] = { text = icons.diagnostics.info },
                        ["Hint"] = { text = icons.diagnostics.hint },
                    },
                },
            },
        })
    end,
}

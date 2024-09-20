return {
  omnisharp = {
    -- Settings from https://gist.github.com/squk/055683bb83d4dbbac418582129f0e3b5
    enable_editorconfig_support = true,
    enable_ms_build_load_projects_on_demand = false, -- default false
    enable_roslyn_analyzers = true,                  -- default false
    organize_imports_on_format = true,               -- default false
    enable_import_completion = true,                 -- default false
    sdk_include_prereleases = true,
    analyze_open_documents_only = true,              -- default false
  },
}

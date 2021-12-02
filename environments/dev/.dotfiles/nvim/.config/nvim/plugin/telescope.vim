" Telescope configuration.
" TODO: Move this to a `.lua` file? Can I mix `.lua` and `.vim` configuration
" files?

lua << EOF

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- ..
    file_ignore_patterns = { "^.git" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
  },
  -- pickers = {
  --   -- Default configuration for builtin pickers goes here:
  --   -- picker_name = {
  --   --   picker_config_key = value,
  --   --   ...
  --   -- }
  --   -- Now the picker_config_key will be applied every time you call this
  --   -- builtin picker
  -- },
  -- extensions = {
  --   -- Your extension configuration goes here:
  --   -- extension_name = {
  --   --   extension_config_key = value,
  --   -- }
  --   -- please take a look at the readme of the extension you want to configure
  -- }
}

require('telescope').load_extension('fzy_native')

EOF

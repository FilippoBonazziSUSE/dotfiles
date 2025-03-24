require'lualine'.setup {
  options = {
    component_separators = { left = '│', right = '│'},
    section_separators = { left = '', right = ''},
  },
  sections = {
    lualine_c = {{'filename', newfile_status = true}},
    lualine_x = {'encoding', {'fileformat', icons_enabled=false}, {'filetype', icons_enabled=false}, 'lsp_status'},
  },
  extensions = {'trouble'},
}

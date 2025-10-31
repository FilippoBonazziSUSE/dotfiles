vim.lsp.config("rpmspec", {
    default_config = {
      cmd = { 'python3', '-mrpm_spec_language_server', '--stdio' },
      filetypes = { 'spec' },
      single_file_support = true,
      root_dir = vim.lsp.util.find_git_ancestor,
      settings = {},
    },
    docs = {
      description = [[
  https://github.com/dcermak/rpm-spec-language-server

  Language server protocol (LSP) support for RPM Spec files.
  ]],
    },
})

vim.lsp.enable("rpmspec")

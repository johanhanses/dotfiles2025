-- Code formatting with conform.nvim

local conform_ok, conform = pcall(require, "conform")
if not conform_ok then
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "yapf" },
    nix = { "nixfmt" },
    ocaml = { "ocamlformat" },
    zig = { "zigfmt" },
    javascript = { "prettier", "biome" },
    typescript = { "prettier", "biome" },
    javascriptreact = { "prettier", "biome" },
    typescriptreact = { "prettier", "biome" },
    json = { "prettier", "biome" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    graphql = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

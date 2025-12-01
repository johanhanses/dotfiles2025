-- LSP Configuration (using vim.lsp.config API for nvim-lspconfig 0.11+)

-- Lua language server
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- TypeScript/JavaScript
vim.lsp.config("ts_ls", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- ESLint
vim.lsp.config("eslint", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  settings = {
    workingDirectories = { mode = "auto" },
  },
})

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})

-- Biome (JS/TS linting and formatting)
vim.lsp.config("biome", {})

-- Python
vim.lsp.config("pyright", {})

-- Go
vim.lsp.config("gopls", {})

-- Rust
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true,
      },
    },
  },
})

-- C/C++
vim.lsp.config("clangd", {})

-- Zig
vim.lsp.config("zls", {})

-- Haskell
vim.lsp.config("hls", {
  filetypes = { "haskell", "lhaskell", "cabal" },
})

-- Java (jdtls)
vim.lsp.config("jdtls", {
  settings = {
    java = {
      format = {
        enabled = false,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      completion = { guessMethodArguments = true },
    },
  },
})

-- Enable all configured servers
vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "eslint",
  "tailwindcss",
  "biome",
  "pyright",
  "gopls",
  "rust_analyzer",
  "clangd",
  "zls",
  "hls",
  "jdtls",
})

-- Diagnostic display configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

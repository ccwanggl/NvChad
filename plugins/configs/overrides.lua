local M = {}
M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "c",
    "cpp",
    "markdown",
    "markdown_inline",
  },

  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}

M.mason = {
  ensure_installed = {
    "lua-language-server",
    "stylua",

    "clangd",
    "neocmakelsp",
    --    "shfmt",
    --    "shell_check",
    "cmakelang",
    "cpplint",
    "clang-format",
    "bash-language-server",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
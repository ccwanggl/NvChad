local present, null_ls = pcall(require, "null-ls")

if not present then
    return
end

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local sources = {

    -- NOTE: webdev stuff
    formatting.deno_fmt,
    formatting.prettier,
    lint.eslint,

    -- NOTE: Lua
    formatting.stylua,

    -- NOTE: Shell
    formatting.shfmt,
    lint.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

    -- NOTE: cpp
    formatting.clang_format,
    lint.cpplint,

    -- NOTE: cmake
    formatting.cmake_format,
    lint.cmake_lint,

    -- NOTE: golang
    formatting.gofumpt,
    formatting.goimports_reviser,
    formatting.golines,
    lint.gospel,

    -- NOTE: csharp
    formatting.csharpier,

    -- NOTE: python
    lint.mypy,
    lint.ruff,
    formatting.black,

    -- NOTE: tsserver
}

--[[
local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params {}, function(err, res, ctx)
    if err then
      local err_msg = type(err) == "string" and err or err.message
      -- you can modify the log message / level (or ignore it completely)
      vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
      return
    end

    -- don't apply results if buffer is unloaded or has been modified
    if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
      return
    end

    if res then
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
      vim.api.nvim_buf_call(bufnr, function()
        vim.cmd "silent noautocmd update"
      end)
    end
  end)
end
]]

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
    -- add your sources / config options here
    sources = sources,
    debug = true,
    --[[
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          async_formatting(bufnr)
        end,
      })
    end
  end,
    ]]
}
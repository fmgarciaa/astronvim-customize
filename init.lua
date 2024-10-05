-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution.
-- It is not meant to be edited frequently. Be cautious if you decide to modify it and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- If Lazy.nvim is not installed, clone it from the GitHub repository.
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
-- Prepend Lazy.nvim to the runtime path to ensure it loads correctly.
vim.opt.rtp:prepend(lazypath)

-- Validate that Lazy.nvim is available and can be loaded.
if not pcall(require, "lazy") then
  -- If Lazy.nvim can't be loaded, display an error message and prompt the user to press a key to exit Neovim.
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true,
    {}
  )
  vim.fn.getchar()
  vim.cmd.quit()
end

-- Vimscript code for clipboard settings in WSL (Windows Subsystem for Linux)
-- Uncomment this code to activate clipboard integration in WSL.
-- This configuration uses Windows utilities (clip.exe and powershell.exe) to handle clipboard operations.
vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe", -- Usa clip.exe para copiar al portapapeles
    ["*"] = "clip.exe", -- Usa clip.exe para ambos registros '*' y '+'
  },
  paste = {
    ["+"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r', ''))", -- Pegar desde el portapapeles usando PowerShell
    ["*"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace('`r', ''))", -- Pegar para ambos registros '*' y '+'
  },
  cache_enabled = 0, -- Deshabilitar cache de portapapeles
}

vim.g.python3_host_prog = "/usr/bin/python3"
-- Cambiar el color de los espacios en blanco
vim.opt.termguicolors = true
require "lazy_setup" -- Load Lazy.nvim setup configuration
require "polish" -- Load custom polish configurations


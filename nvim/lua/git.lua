-- Git integration

-- Neogit setup
local neogit_ok, neogit = pcall(require, "neogit")
if neogit_ok then
  neogit.setup({})
end

-- Gitlinker setup (generate GitHub URLs)
local gitlinker_ok, gitlinker = pcall(require, "gitlinker")
if gitlinker_ok then
  gitlinker.setup()
end

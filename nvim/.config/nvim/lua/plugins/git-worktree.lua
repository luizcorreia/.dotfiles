local Worktree = require 'git-worktree'

Worktree.on_tree_change(function(op, path, upstream)
  print('HELLO', op, path, upstream)
  if op == Worktree.Operations.Switch then
  elseif op == Worktree.Operations.Create then
  end
end)

local function is_smiles(path)
  local found = path:find(vim.env['SMILES'])
  return type(found) == 'number' and found > 0
end

local M = {}
function M.execute(op, path, just_build)
  if is_smiles(path) then
    local command = string.format(':silent !tmux-smiles tmux %s %s', path, just_build)
    vim.cmd(command)
  elseif op == Worktree.Operations.Switch then
  elseif op == Worktree.Operations.Create then
  end
end

Worktree.on_tree_change(function(
  op,
  path,
  _ --[[upstream]]
)
  print('HELLO', op, path)
  -- M.execute(op, path.path)
end)

return M

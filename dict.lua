local M = {}

function M.keys(dict)
  local keys = {}
  for k, _ in pairs(dict) do table.insert(keys, k) end
  table.sort(keys)
  return keys
end

function M.flip(dict)
  local r = {}
  for k, v in pairs(dict) do r[v] = k end
  return r
end

return M

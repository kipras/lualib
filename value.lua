local M = {}

function M.clone(val)
  if type(val) == "table" then
    local r = {}
    for k, v in pairs(val) do
      r[k] = clone(v)
    end
    return r
  else
    return val
  end
end

return M

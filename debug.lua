local M = {}

function M.to_str(table, lvl, tbls_seen)
  lvl = lvl or 1
  local indent = string.rep('  ', lvl)

  if type(table) ~= "table" then
    return tostring(table)
  end

  if tbls_seen == nil then tbls_seen = {} end

  local res = '{'
  for key, value in pairs(table) do
    if type(value) == "table" then
      if tbls_seen[value] then
        res = res .. "\n" .. indent .. tostring(key) .. "=**recursion**,"
      else
        tbls_seen[value] = true
        res  = res .. "\n" .. indent .. tostring(key) .. "="
            .. M.to_str(value, lvl + 1, tbls_seen) .. ","
      end
    else
      if type(value) == "string" then value = '"'..value..'"' end
      res = res .. "\n" .. indent .. tostring(key) .. "=" .. tostring(value)
          .. ","
    end
  end
  res = res .. "  }"

  return res
end

function M.p(val)
  print(M.to_str(val))
end

---Penlight pretty print function
M.pp = require 'pl.pretty'.dump

---Table to string convertion function
M.s = require 'pl.pretty'.write

return M

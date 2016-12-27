local M = {}

function M.urlencode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w ])",
      function (c) return string.format ("%%%02X", string.byte(c)) end)
    str = string.gsub (str, " ", "+")
  end
  return str
end

function M.split(str, separator)
  local t, ll
  t = {}
  ll = 0
  if #str == 1 then return {str} end
  while true do
    local l = string.find(str, separator, ll, true) -- find the next separator in the string
    if l ~= nil then -- if found then..
      table.insert(t, string.sub(str, ll, l - 1))
      ll = l + #separator
    else
      table.insert(t, string.sub(str, ll)) -- Save what's left in our array.
      break
    end
  end
  return t
end

---Remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
function M.trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function M.ltrim(s)
  return (s:gsub("^%s*(.*)", "%1"))
end

return M

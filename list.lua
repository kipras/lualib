---List methods. Generic table methods should be put in table.lua instead

local M = {}

function M.fold(list, init, f)
  local val = init
  for _, x in ipairs(list) do val = f(x, val) end
  return val
end

function M.sub(list, from, to)
  to = to and math.min(to, #list) or #list
  local r = {}
  for i = from, to do table.insert(r, list[i]) end
  return r
end

function M.join(...)
  local lists = {...}
  local r = {}
  for _, l in ipairs(lists) do
    for _, val in ipairs(l) do
      table.insert(r, val)
    end
  end
  return r
end

--function M.shuffle(list)
--  local r = {}
--  while #list > 0 do
--    tbl_insert(queues, tbl_remove(self.queues, math_random(#self.queues)))
--  end
--  return r
--end

---Immutable shuffle version - returns a new list, which is a shuffled
-- version of the original list. The original list is not modified.
-- IMPORTANT: run math.seed() before calling shuffle()
function M.shuffle(list)
  local shuffled = {}
  local n = #list
  local indexes = {}
  for i = 1, n do table.insert(indexes, i) end
  while n >= 1 do
    local idx = table.remove(indexes, math.random(n))
    table.insert(shuffled, list[idx])
    n = n - 1
  end
  return shuffled
end

---Mutable shuffle version - changes the original list. May be faster
-- than the immutable version.
-- IMPORTANT: run math.seed() before calling shuffle_mut()
function M.shuffle_mut(list)
  local n = #list
  while n > 2 do
    local k = math.random(n)
    -- swap elements
    list[n], list[k] = list[k], list[n]
    n = n - 1
  end
end

return M

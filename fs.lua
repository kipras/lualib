local lfs = require "lfs"

local M = {}

function M.script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end

-- code by AlexanderMarinov
-- Compatible with Lua 5.1 (not 5.0).
function M.dirtree(dir)
  assert(dir and dir ~= "", "directory parameter is missing or empty")
  if string.sub(dir, -1) == "/" then
    dir=string.sub(dir, 1, -2)
  end

  local diriters = {lfs.dir(dir)}
  local dirs = {dir}

  return function()
    repeat
      local entry = diriters[#diriters]()
      if entry then
        if entry ~= "." and entry ~= ".." then
          local filename = table.concat(dirs, "/").."/"..entry
          local attr = lfs.attributes(filename)
          if attr.mode == "directory" then
            table.insert(dirs, entry)
            table.insert(diriters, lfs.dir(filename))
          end
          return filename, attr
        end
      else
        table.remove(dirs)
        table.remove(diriters)
      end
    until #diriters==0
  end
end

function M.is_dir(path)
  return lfs.attributes(path, 'mode') == 'directory'
end

function M.is_file(path)
  return lfs.attributes(path, 'mode') == 'file'
end


return M

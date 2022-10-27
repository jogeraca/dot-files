function SafeRequire(modname)
  local is_ok, mod = pcall(require, tostring(modname))
  if not is_ok or  mod == nil or mod == '' then
    error("Error cargando la configuracion de " .. tostring(modname))
    return
  else
    return mod
  end
end

require "utils.utils"

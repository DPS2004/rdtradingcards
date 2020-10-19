dpf = {json = require('libs/json')}


function dpf.loadjson(f,w)
  local cf = io.open(f, "r+")
  if cf == nil then
    cf = io.open(f, "w")
    cf:write(dpf.json.encode(w))
    cf:close()
    cf = io.open(f, "r+")
  end
  return dpf.json.decode(cf:read("*a"))
end

function dpf.savejson(f,w)
  local cf = io.open(f, "w")
  cf:write(dpf.json.encode(w))
  cf:close()
end


return dpf
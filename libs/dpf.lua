dpf = {json = require('libs/json')}


function dpf.loadjson(f,w)
  local cf = io.open(f, "r+")
  if cf == nil then
    cf = io.open(f, "w")
    cf:write(dpf.json.encode(w))
    cf:close()
    cf = io.open(f, "r+")
  end
  local filejson = dpf.json.decode(cf:read("*a"))
  cf:close()
  return filejson
end

function dpf.savejson(f,w)
  local cf = io.open(f, "w")
  cf:write(dpf.json.encode(w))
  cf:close()
end


return dpf
local item = {}

function item.run(uj,ujf,message,mt)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local boxstring = ""
  for i,v in ipairs(wj.boxpool) do
    boxstring = boxstring .. fntoname(v) .. "\n"
  end
  uj.consumables.xraygoggles = uj.consumables.xraygoggles - 1
  if uj.consumables.xraygoggles == 0 then
    uj.consumables.xraygoggles = nil
  end
  dpf.savejson(ujf,uj)
  message.author:send("The **Mysterious Box** contains:\n"..boxstring)
  
  
  
end
return item
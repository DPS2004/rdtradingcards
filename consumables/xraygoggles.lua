local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local boxstring = ""
  for i,v in ipairs(wj.boxpool) do
    boxstring = boxstring .. cdb[v].name .. "\n"
  end
  
  uj.consumables["xraygoggles"] = uj.consumables["xraygoggles"] - 1
  if uj.consumables["xraygoggles"] == 0 then uj.consumables["xraygoggles"] = nil end
  uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

  dpf.savejson(ujf, uj)
  message.author:send("The **Peculiar Box** contains:\n" .. boxstring)
end
return item
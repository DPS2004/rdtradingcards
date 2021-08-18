local item = {}

function item.run(uj,ujf,message,mt)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  wj.boxpool = {constable["aboveur"][math.random(#constable["aboveur"])]}
  for i = 1, 21 do
    table.insert(wj.boxpool,ptable["nothing"][math.random(#ptable["nothing"])])
  end
  
  uj.consumables["replacementvoid"] = uj.consumables["replacementvoid"] - 1
  if uj.consumables["replacementvoid"] == 0 then uj.consumables["replacementvoid"] = nil end
  uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
  dpf.savejson("savedata/worldsave.json", wj)
  dpf.savejson(ujf, uj)
  message.channel:send("As you put the **Replacement Void** into the **Mysterious Box**, you can feel the box suddenly get much warmer, and then as cold as ice within the blink of an eye.")
end
return item
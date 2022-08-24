local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  wj.boxpool = { constable["aboveur"][math.random(#constable["aboveur"])] }
  for i = 1, 21 do
    table.insert(wj.boxpool, ptable["nothing"][math.random(#ptable["nothing"])])
  end

  uj.consumables["replacementvoid"] = uj.consumables["replacementvoid"] - 1
  if uj.consumables["replacementvoid"] == 0 then uj.consumables["replacementvoid"] = nil end
  uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
  dpf.savejson("savedata/worldsave.json", wj)
  dpf.savejson(ujf, uj)

  local replying = interaction or message
  replying:reply(lang.replacementvoid_message)
end

return item

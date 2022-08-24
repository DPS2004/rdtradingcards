local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local time = sw:getTime()
  uj.consumables["granolabar"] = uj.consumables["granolabar"] - 1
  if uj.consumables["granolabar"] == 0 then uj.consumables["granolabar"] = nil end
  uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

  uj.lastpull = uj.lastpull - 3
  uj.lastprayer = uj.lastprayer - 3/24
  uj.lastbox = uj.lastbox - 3
  uj.lastequip = uj.lastequip - 3
  dpf.savejson(ujf, uj)
  local replying = interaction or message
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  replying:reply(lang.granolabar_message)
end

return item

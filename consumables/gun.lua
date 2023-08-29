local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local time = sw:getTime()
  uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
  dpf.savejson(ujf, uj)
  local replying = interaction or message
  if uj.robconspt == "none" or not uj.robconspt then
    uj.consumables["gun"] = uj.consumables["gun"] - 1
    if uj.consumables["gun"] == 0 then uj.consumables["gun"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    uj.robconspt = "gun"
    replying:reply(lang.gun_message)
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.gun_robconspt)
  end
end

return item

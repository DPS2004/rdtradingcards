local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["hauntedgrass"] = uj.consumables["hauntedgrass"] - 1
    if uj.consumables["hauntedgrass"] == 0 then uj.consumables["hauntedgrass"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "deviltail"
    replying:reply(lang.hauntedgrass_message)
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply(lang.cooldown_decrease_1 .. randtime .. lang.cooldown_decrease_2)
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.hauntedgrass_conspt)
  end
end

return item

local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["clownnose"] = uj.consumables["clownnose"] - 1
    if uj.consumables["clownnose"] == 0 then uj.consumables["clownnose"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "duncecap"
    replying:reply(lang.clownnose_message)
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply(lang.cooldown_decrease_1 .. randtime .. lang.cooldown_decrease_2)
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.clownnose_conspt)
  end
end

return item

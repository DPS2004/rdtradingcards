local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["oldfiles"] = uj.consumables["oldfiles"] - 1
    if uj.consumables["oldfiles"] == 0 then uj.consumables["oldfiles"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "oldfiles"
    replying:reply(lang.oldfiles_message)
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply(lang.cooldown_decrease_1 .. randtime .. lang.cooldown_decrease_2)
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.oldfiles_conspt)
  end
end

return item

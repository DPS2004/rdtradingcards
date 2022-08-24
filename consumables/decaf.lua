local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["decaf"] = uj.consumables["decaf"] - 1
    if uj.consumables["decaf"] == 0 then uj.consumables["decaf"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "cafemixtape"
    replying:reply(lang.decaf_message)
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply(lang.cooldown_decrease_1 .. randtime .. lang.cooldown_decrease_2)
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.decaf_conspt)
  end
end

return item

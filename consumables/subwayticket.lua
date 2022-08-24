local item = {}

function item.run(uj, ujf, message, mt, interaction)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/cons.json")
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["subwayticket"] = uj.consumables["subwayticket"] - 1
    if uj.consumables["subwayticket"] == 0 then uj.consumables["subwayticket"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "sbubby"
    replying:reply(lang.subwayticket_message)
    local randtime = math.random(12, 24)
    uj.lastpull = uj.lastpull - randtime
    message:reply(lang.cooldown_decrease_1 .. randtime .. lang.cooldown_decrease_2)
    dpf.savejson(ujf, uj)
  else
    replying:reply(lang.subwayticket_conspt)
  end
end

return item

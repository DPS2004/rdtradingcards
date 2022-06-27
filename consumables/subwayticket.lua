local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["subwayticket"] = uj.consumables["subwayticket"] - 1
    if uj.consumables["subwayticket"] == 0 then uj.consumables["subwayticket"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "sbubby"
    replying:reply("You tear up the **Subway Ticket**. This will surely.")
    local randtime = math.random(12, 24)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')
    dpf.savejson(ujf, uj)
  else
    replying:reply("You already have a pull affecting item in use! You decide against using the **Subway Ticket** for now.")
  end
end

return item

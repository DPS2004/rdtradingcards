local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["breadcrumbs"] = uj.consumables["breadcrumbs"] - 1
    if uj.consumables["breadcrumbs"] == 0 then uj.consumables["breadcrumbs"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "deluxebirdseed"
    replying:reply("You eat all of the **Breadcrumbs** yourself. Surely this will lure in some birds into your location.")
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')
    dpf.savejson(ujf, uj)
  else
    replying:reply("You already have a pull affecting item in use! You decide against using the **Breadcrumbs** for now.")
  end
end

return item

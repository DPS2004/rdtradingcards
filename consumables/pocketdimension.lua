local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["pocketdimension"] = uj.consumables["pocketdimension"] - 1
    if uj.consumables["pocketdimension"] == 0 then uj.consumables["pocketdimension"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "pocketdimension"
    replying:reply("You smash your **Pocket Dimension** on the floor. You immediately regret it, but at least the next card you pull is guaranteed to be an Alternate one.")
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')
    dpf.savejson(ujf, uj)
  else
    replying:reply("You already have a pull affecting item in use! You decide against using the **Pocket Dimension** at this time.")
  end
end

return item

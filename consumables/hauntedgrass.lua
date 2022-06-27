local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["hauntedgrass"] = uj.consumables["hauntedgrass"] - 1
    if uj.consumables["hauntedgrass"] == 0 then uj.consumables["hauntedgrass"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "deviltail"
    replying:reply("You plant the **Haunted Grass** in your garden. This will surely attract the attention of some spooky things!")
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')
    dpf.savejson(ujf, uj)
  else
    replying:reply("You already have a pull affecting item in use! You decide against using the **Haunted Grass** for now.")
  end
end

return item

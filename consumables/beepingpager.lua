local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["beepingpager"] = uj.consumables["beepingpager"] - 1
    if uj.consumables["beepingpager"] == 0 then uj.consumables["beepingpager"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "oversizedstethoscope"
    replying:reply("You place the **Beeping Pager** down on a busy hospital hallway. This will surely lure in some overworked medical staff.")
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')
    dpf.savejson(ujf, uj)
  else
    replying:reply("You already have a pull affecting item in use! You decide against using the **Beeping Pager** at this time.")
  end
end

return item

local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["secretadmirersnote"] = uj.consumables["secretadmirersnote"] - 1
    if uj.consumables["secretadmirersnote"] == 0 then uj.consumables["secretadmirersnote"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "valentinesdaycard"
    replying:reply("You discretely place the **Secret Admirers Note** inside of a school locker. This will surely attract the attention of lovestruck teens.")
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')
    dpf.savejson(ujf, uj)
  else
    replying:reply("You already have a pull affecting item in use! You decide against using the **Secret Admirers Note** for now.")
  end
end

return item

local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  local replying = interaction or message
  if uj.conspt == "none" then
    uj.consumables["tapiocapudding"] = uj.consumables["tapiocapudding"] - 1
    if uj.consumables["tapiocapudding"] == 0 then uj.consumables["tapiocapudding"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1

    uj.conspt = "hardcandy"
    replying:reply("You place down the **Tapioca Pudding** on a table in the hospital's cafeteria. This will surely attract the attention of elderly patients.")
    local randtime = math.random(4, 8)
    uj.lastpull = uj.lastpull - randtime
    message:reply('Also, your pull cooldown was decreased by ' .. randtime .. ' hours!')
    dpf.savejson(ujf, uj)
  else
    replying:reply("You already have a pull affecting item in use! You decide against using the **Tapioca Pudding** for now.")
  end
end

return item

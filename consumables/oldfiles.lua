local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["oldfiles"] = uj.consumables["oldfiles"] - 1
    if uj.consumables["oldfiles"] == 0 then uj.consumables["oldfiles"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "oldfiles"
    interaction:reply("You install some **Old Files** onto your computer. This will surely attract some old video game sprites.")
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	interaction:reply('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    interaction:reply("You already have a pull affecting item in use! You decide against using the **Old Files** at this time.")
  end
end
return item
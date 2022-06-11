local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["decaf"] = uj.consumables["decaf"] - 1
    if uj.consumables["decaf"] == 0 then uj.consumables["decaf"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "cafemixtape"
    interaction:reply("You set down the **Decaf** cup near the set of a medieval fantasy TV show being filmed. This will surely attract the attention of coffeeshop staff and regulars.")
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	interaction:reply('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    interaction:reply("You already have a pull affecting item in use! You decide against using the **Decaf** for now.")
  end
end
return item
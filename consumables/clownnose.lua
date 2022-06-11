local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["clownnose"] = uj.consumables["clownnose"] - 1
    if uj.consumables["clownnose"] == 0 then uj.consumables["clownnose"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "duncecap"
    interaction:reply("You don the **Clown Nose** and proceed to say some poorly thought-out, controversial opinions. Surely this will attract the attention of `sh*tposts`.")
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	interaction:reply('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    interaction:reply("You already have a pull affecting item in use! You decide against using the **Clown Nose** at this time.")
  end
end
return item
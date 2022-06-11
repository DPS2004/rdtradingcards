local item = {}

function item.run(uj, ujf, message, mt, interaction)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["fancyteaset"] = uj.consumables["fancyteaset"] - 1
    if uj.consumables["fancyteaset"] == 0 then uj.consumables["fancyteaset"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "rustysword"
    interaction:reply("You set the **Fancy Tea Set** down on the traditional tea-drinking rug. This will surely lure in some battle-worn samurai into your location.")
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	interaction:reply('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    interaction:reply("You already have a pull affecting item in use! You decide against using the **Fancy Tea Set** at this time.")
  end
end
return item
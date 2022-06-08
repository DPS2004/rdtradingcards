local item = {}

function item.run(uj, ujf, message, mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["butterypopcorn"] = uj.consumables["butterypopcorn"] - 1
    if uj.consumables["butterypopcorn"] == 0 then uj.consumables["butterypopcorn"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "filmreel"
    message.channel:send("You shovel the **Buttery Popcorn** into your mouth. This will surely attract some animated cards!")
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	message.channel:send('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    message.channel:send("You already have a pull affecting item in use! You decide against eating the **Buttery Popcorn** at this time.")
  end
end
return item
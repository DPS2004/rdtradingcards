local item = {}

function item.run(uj, ujf, message, mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["quantummouse"] = uj.consumables["quantummouse"] - 1
    if uj.consumables["quantummouse"] == 0 then uj.consumables["quantummouse"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "quantummouse"
    message.channel:send("The **Quantum Mouse** somehow squeaks as you observe it being placed down. Surely you can get more cards from this.")
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	message.channel:send('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Quantum Mouse** for now.")
  end
end
return item
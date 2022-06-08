local item = {}

function item.run(uj, ujf, message, mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["spicymintgum"] = uj.consumables["spicymintgum"] - 1
    if uj.consumables["spicymintgum"] == 0 then uj.consumables["spicymintgum"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "swirlymarbles"
    message.channel:send("You unwrap the **Spicy Mint Gum** and start chewing on a stick. This will surely attract some ADOFAI cards!")
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	message.channel:send('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    message.channel:send("You already have a pull affecting item in use! You decide against chewing on the **Spicy Mint Gum** at this time.")
  end
end
return item
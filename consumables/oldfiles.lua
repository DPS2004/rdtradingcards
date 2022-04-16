local item = {}

function item.run(uj, ujf, message, mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["oldfiles"] = uj.consumables["oldfiles"] - 1
    if uj.consumables["oldfiles"] == 0 then uj.consumables["oldfiles"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "oldfiles"
    dpf.savejson(ujf, uj)
    message.channel:send("You install some **Old Files** onto your computer. This will surely attract some old video game sprites.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Old Files** at this time.")
  end
end
return item
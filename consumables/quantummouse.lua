local item = {}

function item.run(uj, ujf, message, mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["quantummouse"] = uj.consumables["quantummouse"] - 1
    if uj.consumables["quantummouse"] == 0 then uj.consumables["quantummouse"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "quantummouse"
    dpf.savejson(ujf, uj)
    message.channel:send("you put down the ***quantum mouse*** or smth. it squeaks lol")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Quantum Mouse** for now.")
  end
end
return item
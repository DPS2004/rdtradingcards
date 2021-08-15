local item = {}

function item.run(uj, ujf, message, mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["stickontabs"] = uj.consumables["stickontabs"] - 1
    if uj.consumables["stickontabs"] == 0 then uj.consumables["stickontabs"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "scribblednotepad"
    dpf.savejson(ujf, uj)
    message.channel:send("You stick the **Stick-on Tabs** inside of your level design notepad. This will surely improve your organizational skills... and also attract some editor cards I guess.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Stick-on Tabs** at this time.")
  end
end
return item
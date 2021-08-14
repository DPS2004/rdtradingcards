local item = {}

function item.run(uj,ujf,message,mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables.fancyteaset = uj.consumables.fancyteaset - 1
    if uj.consumables.fancyteaset == 0 then
      uj.consumables.fancyteaset = nil
    end
    if not uj.timesitemused then 
      uj.timesitemused = 1 
    else
      uj.timesitemused = uj.timesitemused + 1
    end
    
    uj.conspt = "rustysword"
    dpf.savejson(ujf,uj)
    message.channel:send("You set the **Fancy Tea Set** down on the traditional tea-drinking rug. This will surely lure in some battle-worn samurai into your location.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Fancy Tea Set** at this time.")
  end
  
  
  
end
return item
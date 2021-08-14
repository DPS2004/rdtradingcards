local item = {}

function item.run(uj,ujf,message,mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables.decaf = uj.consumables.decaf - 1
    if uj.consumables.decaf == 0 then
      uj.consumables.decaf = nil
    end
    if not uj.timesitemused then 
      uj.timesitemused = 1 
    else
      uj.timesitemused = uj.timesitemused + 1
    end
    
    uj.conspt = "cafemixtape"
    dpf.savejson(ujf,uj)
    message.channel:send("You set down the **Decaf** cup near the set of a medieval fantasy TV show being filmed. This will surely attract the attention of coffeeshop staff and regulars.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Decaf** for now.")
  end
  
  
  
end
return item
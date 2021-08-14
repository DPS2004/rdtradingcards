local item = {}

function item.run(uj,ujf,message,mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables.tapiocapudding = uj.consumables.tapiocapudding - 1
    if uj.consumables.tapiocapudding == 0 then
      uj.consumables.tapiocapudding = nil
    end
    if not uj.timesitemused then 
      uj.timesitemused = 1 
    else
      uj.timesitemused = uj.timesitemused + 1
    end
    
    uj.conspt = "hardcandy"
    dpf.savejson(ujf,uj)
    message.channel:send("You place down the **Tapioca Pudding** on a table in the hospital's cafeteria. This will surely attract the attention of elderly patients.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Tapioca Pudding** for now.")
  end
  
  
  
end
return item
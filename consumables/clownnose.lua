local item = {}

function item.run(uj,ujf,message,mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables.clownnose = uj.consumables.clownnose - 1
    if uj.consumables.clownnose == 0 then
      uj.consumables.clownnose = nil
    end
    if not uj.timesitemused then 
      uj.timesitemused = 1 
    else
      uj.timesitemused = uj.timesitemused + 1
    end
    
    uj.conspt = "duncecap"
    dpf.savejson(ujf,uj)
    message.channel:send("You don the **Clown Nose** and proceed to say some poorly thought-out, controversial opinions. Surely this will attract the attention of `sh*tposts`.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Clown Nose** at this time.")
  end
  
  
  
end
return item
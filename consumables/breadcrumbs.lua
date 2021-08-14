local item = {}

function item.run(uj,ujf,message,mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables.breadcrumbs = uj.consumables.breadcrumbs - 1
    if uj.consumables.breadcrumbs == 0 then
      uj.consumables.breadcrumbs = nil
    end
    if not uj.timesitemused then 
      uj.timesitemused = 1 
    else
      uj.timesitemused = uj.timesitemused + 1
    end
      
    uj.conspt = "deluxebirdseed"
    
    dpf.savejson(ujf,uj)
    message.channel:send("You eat all of the **Breadcrumbs** yourself. Surely this will lure in some birds into your location.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Breadcrumbs** for now.")
  end
  
  
  
end
return item
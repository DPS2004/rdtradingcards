local item = {}

function item.run(uj,ujf,message,mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables.beepingpager = uj.consumables.beepingpager - 1
    if uj.consumables.beepingpager == 0 then
      uj.consumables.beepingpager = nil
    end
    if not uj.timesitemused then 
      uj.timesitemused = 1 
    else
      uj.timesitemused = uj.timesitemused + 1
    end
    
    uj.conspt = "oversizedstethoscope"
    dpf.savejson(ujf,uj)
    message.channel:send("You place the **Beeping Pager** down on a busy hospital hallway. This will surely lure in some overworked medical staff.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Beeping Pager** at this time.")
  end
  
  
  
end
return item
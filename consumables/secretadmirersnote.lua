local item = {}

function item.run(uj, ujf, message, mt)
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables["secretadmirersnote"] = uj.consumables["secretadmirersnote"] - 1
    if uj.consumables["secretadmirersnote"] == 0 then uj.consumables["secretadmirersnote"] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
    
    uj.conspt = "valentinesdaycard"
    dpf.savejson(ujf, uj)
    message.channel:send("You discretely place the **Secret Admirers Note** inside of a school locker. This will surely attract the attention of lovestruck teens.")
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **Secret Admirers Note** for now.")
  end
end
return item
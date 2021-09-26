local item = {}

function item.run(uj, ujf, message, mt,fn)
  local itemname = consumabledb[fn].name
  local itemtext = consumabledb[fn].text
  local season = consumabledb[fn].season
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables[fn] = uj.consumables[fn] - 1
    if uj.consumables[fn] == 0 then uj.consumables[fn] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
      
    uj.conspt = "season"..season
    dpf.savejson(ujf, uj)
    message.channel:send(itemtext)
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **"..itemname.."** for now.")
  end
end
return item
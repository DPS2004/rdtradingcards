local item = {}

function item.run(uj, ujf, message, mt,fn)
  local itemname = consdb[fn].name
  local itemtext = consdb[fn].text
  local season = consdb[fn].season
  if not uj.conspt then uj.conspt = "none" end
  if uj.conspt == "none" then
    uj.consumables[fn] = uj.consumables[fn] - 1
    if uj.consumables[fn] == 0 then uj.consumables[fn] = nil end
    uj.timesitemused = uj.timesitemused and uj.timesitemused + 1 or 1
      
    uj.conspt = "season"..season
    message.channel:send(itemtext)
	local randtime = math.random(4,8)
	uj.lastpull = uj.lastpull - randtime
	message.channel:send('Also, your pull cooldown was decreased by '..randtime..' hours!')
    dpf.savejson(ujf, uj)
  else
    message.channel:send("You already have a pull affecting item in use! You decide against using the **"..itemname.."** for now.")
  end
end
return item
local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !catch")

  if not message.guild then
    message.channel:send("Sorry, but you cannot catch cards in DMs!")
    return
  end

  if not (#mt == 1) then
    message.channel:send("Sorry, but the c!catch command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local tj = dpf.loadjson("savedata/throwncards.json", {})

  local curfilename = texttofn(mt[1])
  
  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or it's not been thrown. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. mt[1] .. " card in the database. Make sure that you spelled it right!")
    end
    return
  end

  if not tj[curfilename] then
    print("user doesnt have card")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. mt[1] .. " card in the database, or it's not been thrown. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but the **" .. fntoname(curfilename) .. "** card has not been thrown!")
    end
    return
  end

  uj.inventory[curfilename] = uj.inventory[curfilename] and uj.inventory[curfilename] + 1 or 1
  uj.timescaught = uj.timescaught and uj.timescaught + 1 or 1
  client:emit(tj[curfilename][1])
  table.remove(tj[curfilename], 1)
  if not next(tj[curfilename]) then tj[curfilename] = nil end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  dpf.savejson("savedata/throwncards.json", tj)

  message.channel:send(message.author.mentionString .. " has caught a **" .. fntoname(curfilename) .. "** card! The **" .. fntoname(curfilename) .. "** card has been added to " .. uj.pronouns["their"] .. " inventory.")
end
return command
  
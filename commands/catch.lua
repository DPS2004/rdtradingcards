local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !catch")

  if not message.guild then
    message.channel:send("Sorry, but you cannot catch in DMs!")
    return
  end

  if not (#mt == 1) then
    message.channel:send("Sorry, but the c!catch command expects 1 argument. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local tj = dpf.loadjson("savedata/thrown.json", {})

  local cardfilename, consfilename = texttofn(mt[1]), constexttofn(mt[1])
  local curfilename = cardfilename or consfilename
  print(curfilename)

  if not curfilename then
    if nopeeking then
      message.channel:send("Sorry, but I either could not find " .. mt[1] .. " in the database, or it's not been thrown. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find " .. mt[1] .. " in the database. Make sure that you spelled it right!")
    end
    return
  end

  local caughtname = cardfilename and cdb[cardfilename].name or consdb[consfilename].name

  if not (tj[curfilename]) then
    print("user doesnt have item")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find " .. mt[1] .. " in the database, or it's not been thrown. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but **" .. caughtname .. "** has not been thrown!")
    end
    return
  end

  if cardfilename then
    uj.inventory[cardfilename] = uj.inventory[cardfilename] and uj.inventory[cardfilename] + 1 or 1
  else
    uj.consumables[consfilename] = uj.consumables[consfilename] and uj.consumables[consfilename] + 1 or 1
  end
  uj.timescaught = uj.timescaught and uj.timescaught + 1 or 1
  client:emit(tj[curfilename][1])
  table.remove(tj[curfilename], 1)
  if not next(tj[curfilename]) then tj[curfilename] = nil end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  dpf.savejson("savedata/thrown.json", tj)

  local item = cardfilename and "card" or "item"
  message.channel:send(message.author.mentionString .. " has caught a **" .. caughtname .. "** " .. item .. "! The **" .. caughtname .. "** " .. item .. " has been added to " .. uj.pronouns["their"] .. " inventory.")
  if not uj.togglecheckcard then
    if not uj.storage[caughtname] then
      message.channel:send('You do not have the **' .. caughtname.. '** card in your storage!')
    end
  end
end
return command

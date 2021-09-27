local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !generategive")
  local cmember = message.guild:getMember(message.author)
  if not cmember:hasRole(privatestuff.modroleid) then
    message.channel:send("haha no, nice try")
    return
  end

  if not (#mt == 2 or #mt == 3) then
    message.channel:send("Sorry, but the c!generategive command expects 2 or 3 arguments. Please see c!help for more details.")
    return
  end

  local uj2f = usernametojson(mt[1])
  if not uj2f then
    message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    return
  end

  local uj2 = dpf.loadjson(uj2f, defaultjson)
  local curfilename = texttofn(mt[2])

  if not curfilename then
    message.channel:send("Sorry, but I could not find the " .. mt[2] .. " card in the database. Make sure that you spelled it right!")
    return
  end

  local numcards = 1
  if tonumber(mt[3]) then
    if tonumber(mt[3]) > 1 then numcards = math.floor(mt[3]) end
  end

  uj2.inventory[curfilename] = uj2.inventory[curfilename] and uj2.inventory[curfilename] + numcards or numcards
  dpf.savejson(uj2f,uj2)
  print("saved user2 json with new card")

  message.channel:send {
    content = 'You have given ' .. numcards .. ' **' .. cdb[curfilename].name .. '** card' .. (numcards == 1 and "" or "s") .. ' to <@' .. uj2.id .. '> .'
  }
end
return command

local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !giveitem")
  
  if not message.guild then
    message.channel:send("Sorry, but you cannot give items in DMs!")
    return
  end
  
  if not (#mt == 2 or #mt == 3) then
    message.channel:send("Sorry, but the c!giveitem command expects 2 or 3 arguments. Please see c!help for more details.")
    return
  end
  
  local user_argument = mt[1]
  local thing_argument = string.lower(mt[2])
  local numitems = 1
  
  if tonumber(mt[3]) then
    if tonumber(mt[3]) > 1 then
      numitems = math.floor(mt[3])
    end
  end
    
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local uj2f = usernametojson(user_argument)

  if not uj.consumables then uj.consumables = {} end

  if mt[3] == "all" then
    numitems = uj.consumables[thing_argument]
  end
  
  if not uj2f then
    message.channel:send("Sorry, but I could not find a user named " .. user_argument .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a item to register!")
    return
  end

  local uj2 = dpf.loadjson(uj2f, defaultjson)

  if not uj2.consumables then uj2.consumables = {} end
  
  if uj2.id == message.author.id then
    message.channel:send("Sorry, but you cannot give something to yourself!")
    return
  end
  
  local curfilename = constexttofn(thing_argument)
  
  if not curfilename then
    if itemtexttofn(thing_argument) then
      message.channel:send("Sorry, but you cannot gift equippable items!")
    elseif nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. thing_argument .. " item in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but I could not find the " .. thing_argument .. " item in the database. Make sure that you spelled it right!")
    end
    return
  end
  
  if not uj.consumables[curfilename] then
    print("user doesnt have item")
    if nopeeking then
      message.channel:send("Sorry, but I either could not find the " .. thing_argument .. " item in the database, or you do not have it. Make sure that you spelled it right!")
    else
      message.channel:send("Sorry, but you don't have the **" .. consdb[curfilename].name .. "** item.")
    end
    return
  end
  
  if not (uj.consumables[curfilename] >= numitems) then
    print("user doesn't have enough items")
    message.channel:send("Sorry, but you do not have enough **" .. consdb[curfilename].name .. "** items.")
    return
  end


  print(uj.consumables[curfilename] .. "before")
  uj.consumables[curfilename] = uj.consumables[curfilename] - numitems
  print(uj.consumables[curfilename] .. "after")
  
  if uj.consumables[curfilename] == 0 then
    uj.consumables[curfilename] = nil
  end
  
  uj.timesitemgiven = (uj.timesitemgiven == nil) and numitems or (uj.timesitemgiven + numitems)
  uj2.timesitemreceived = (uj2.timesitemreceived == nil) and numitems or (uj2.timesitemreceived + numitems)
  
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  print("user had item, removed from original user")
  
  uj2.consumables[curfilename] = (uj2.consumables[curfilename] == nil) and numitems or (uj2.consumables[curfilename] + numitems)
  
  dpf.savejson(uj2f,uj2)
  print("saved user2 json with new item")
  
  local isplural = numitems ~= 1 and "s" or ""
  message.channel:send {
    content = 'You have gifted ' .. numitems .. ' **' .. consdb[curfilename].name .. '** item' .. isplural ..' to <@' .. uj2.id .. '>.'
  }


end
return command

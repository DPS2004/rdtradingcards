local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !give")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/give.json", "")
  
  if not message.guild then
    message.channel:send(lang.dm_message)
    return
  end
  
  if not (#mt == 2 or #mt == 3) then
    message.channel:send(lang.no_arguments)
    return
  end
  
  local user_argument = mt[1]
  local thing_argument = string.lower(mt[2])
  local numcards = 1
  
  if tonumber(mt[3]) then
    if tonumber(mt[3]) > 1 then
      numcards = math.floor(mt[3])
    end
  end
  
  if thing_argument == "token" then
    cmd.givetoken.run(message, {user_argument, numcards})
    return
  end

  if constexttofn(thing_argument) or itemtexttofn(thing_argument) then
    cmd.giveitem.run(message, {user_argument, thing_argument, numcards})
    return
  end
    
  local uj2f = usernametojson(user_argument)

  if mt[3] == "all" then
    numcards = uj.inventory[thing_argument]
  end
  
  if not uj2f then
    message.channel:send(lang.no_user_1 .. user_argument .. lang.no_user_2)
    return
  end

  local uj2 = dpf.loadjson(uj2f, defaultjson)
  local lang2 = dpf.loadjson("langs/" .. uj2.lang .. "/give.json","")
  
  if uj2.id == message.author.id then
    message.channel:send(lang.same_user)
    return
  end
  
  local curfilename = texttofn(thing_argument)
  
  if not curfilename then
    if nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. thing_argument .. lang.no_item_nopeeking_2)
    else
      message.channel:send(lang.no_item_1 .. thing_argument .. lang.no_item_2)
    end
    return
  end
  
  if not uj.inventory[curfilename] then
    print("user doesnt have card")
    if nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. thing_argument .. lang.no_item_nopeeking_2)
    else
      message.channel:send(lang.dont_have_1 .. cdb[curfilename].name .. lang.dont_have_2)
    end
    return
  end
  
  if not (uj.inventory[curfilename] >= numcards) then
    print("user doesn't have enough cards")
    message.channel:send(lang.not_enough_1 .. cdb[curfilename].name .. lang.not_enough_2)
    return
  end


  print(uj.inventory[curfilename] .. "before")
  uj.inventory[curfilename] = uj.inventory[curfilename] - numcards
  print(uj.inventory[curfilename] .. "after")
  
  if uj.inventory[curfilename] == 0 then
    uj.inventory[curfilename] = nil
  end
  
  uj.timescardgiven = (uj.timescardgiven == nil) and numcards or (uj.timescardgiven + numcards)
  uj2.timescardreceived = (uj2.timescardreceived == nil) and numcards or (uj2.timescardreceived + numcards)
  
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  print("user had card, removed from original user")
  
  uj2.inventory[curfilename] = (uj2.inventory[curfilename] == nil) and numcards or (uj2.inventory[curfilename] + numcards)
  
  dpf.savejson(uj2f,uj2)
  print("saved user2 json with new card")
  
  local isplural = numcards ~= 1 and lang.needs_plural_s == true and lang.plural_s or ""
  local isplural2 = numcards ~= 1 and lang2.needs_plural_s == true and lang2.plural_s or ""
  
  if uj.lang == "ko" then
    _G['giftedmessage'] = lang.gifted_message_1 .. uj2.id .. lang.gifted_message_2 .. cdb[curfilename].name .. lang.gifted_message_3 .. numcards .. lang.gifted_message_4 .. lang.gifted_message_5
  else
    _G['giftedmessage'] = lang.gifted_message_1 .. numcards .. lang.gifted_message_2 .. cdb[curfilename].name .. lang.gifted_message_3 .. isplural .. lang.gifted_message_4 .. uj2.id .. lang.gifted_message_5
  end
  if uj2.lang == "ko" then
    _G['recievedmessage'] = lang2.recieved_message_1 .. uj.id .. lang2.recieved_message_2 .. cdb[curfilename].name .. lang2.recieved_message_3 .. numcards .. lang2.recieved_message_4 .. lang2.recieved_message_5
  else
    _G['recievedmessage'] = lang2.recieved_message_1 .. uj.id .. lang2.recieved_message_2 .. numcards .. lang2.recieved_message_3 .. cdb[curfilename].name .. lang2.recieved_message_4 .. isplural2 .. lang2.recieved_message_5
  end
  if uj.lang == uj2.lang then
    message.channel:send {
      content = giftedmessage
	}
  else
    message.channel:send {
      content = giftedmessage .. "\n" .. recievedmessage
    }
  end


end
return command

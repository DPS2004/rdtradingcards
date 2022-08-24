local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !giveitem")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json", defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/giveitem.json", "")
  
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
  local numitems = 1
  
  if tonumber(mt[3]) then
    if tonumber(mt[3]) > 1 then
      numitems = math.floor(mt[3])
    end
  end
    
  local uj2f = usernametojson(user_argument)

  if not uj.consumables then uj.consumables = {} end

  if mt[3] == "all" then
    numitems = uj.consumables[thing_argument]
  end
  
  if not uj2f then
    message.channel:send(lang.no_user_1 .. user_argument .. lang.no_user_2)
    return
  end

  local uj2 = dpf.loadjson(uj2f, defaultjson)
  local lang2 = dpf.loadjson("langs/" .. uj2.lang .. "/giveitem.json", "")

  if not uj2.consumables then uj2.consumables = {} end
  
  if uj2.id == message.author.id then
    message.channel:send(lang.same_user)
    return
  end
  
  local curfilename = constexttofn(thing_argument)
  
  if not curfilename then
    if itemtexttofn(thing_argument) then
      message.channel:send(lang.equippable_item)
    elseif nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. thing_argument .. lang.no_item_nopeeking_2)
    else
      message.channel:send(lang.no_item_1 .. thing_argument .. lang.no_item_2)
    end
    return
  end
  
  if not uj.consumables[curfilename] then
    print("user doesnt have item")
    if nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. thing_argument .. lang.no_item_nopeeking_2)
    else
      message.channel:send(lang.dont_have_1 .. consdb[curfilename].name .. lang.dont_have_2)
    end
    return
  end
  
  if not (uj.consumables[curfilename] >= numitems) then
    print("user doesn't have enough items")
    message.channel:send(lang.not_enough_1 .. consdb[curfilename].name .. lang.not_enough_2)
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
  
  local isplural = numitems ~= 1 and lang.needs_plural_s == true and "s" or ""
  local isplural2 = numitems ~= 1 and lang2.needs_plural_s == true and "s" or ""
  
  if uj.lang == "ko" then
    _G['giftedmessage'] = lang.gifted_message_1 .. uj2.id .. lang.gifted_message_2 .. cdb[curfilename].name .. lang.gifted_message_3 .. numitems .. lang.gifted_message_4 .. lang.gifted_message_5
  else
    _G['giftedmessage'] = lang.gifted_message_1 .. numitems .. lang.gifted_message_2 .. cdb[curfilename].name .. lang.gifted_message_3 .. isplural .. lang.gifted_message_4 .. uj2.id .. lang.gifted_message_5
  end
  if uj2.lang == "ko" then
    _G['recievedmessage'] = lang2.recieved_message_1 .. uj.id .. lang2.recieved_message_2 .. cdb[curfilename].name .. lang2.recieved_message_3 .. numitems .. lang2.recieved_message_4 .. lang2.recieved_message_5
  else
    _G['recievedmessage'] = lang2.recieved_message_1 .. uj.id .. lang2.recieved_message_2 .. numitems .. lang2.recieved_message_3 .. cdb[curfilename].name .. lang2.recieved_message_4 .. isplural2 .. lang2.recieved_message_5
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

local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !trade")
  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/trade.json", "")
  if not message.guild then
    message.channel:send(lang.dm_message)
    return
  end

  if #mt ~= 3 then
    message.channel:send(lang.no_arguments)
    return
  end

  local uj2f = usernametojson(mt[2])

  print("checking if user 2 exists")
  if not uj2f then
    message.channel:send(lang.no_user_1 .. mt[2] .. lang.no_user_2)
    return
  end

  print("checking if users are different people")
  if uj2f == ujf then
    message.channel:send(lang.same_user)
    return
  end

  print("checking if item 1 exists")
  local item1 = texttofn(mt[1])
  if not item1 then
    if nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. mt[1] .. lang.no_item_nopeeking_2 .. lang.no_item1_nopeeking)
    else
      message.channel:send(lang.no_item_1 .. mt[1] .. lang.no_item_2)
    end
    return
  end

  print("checking if item 2 exists")
  local item2 = texttofn(mt[3])
  if not item2 then
    if nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. mt[3] .. lang.no_item_nopeeking_2.. mt[2] .. lang.no_item2_nopeeking)
    else
      message.channel:send(lang.no_item_1 .. mt[3] .. lang.no_item_2)
    end
    return
  end

  local uj2 = dpf.loadjson(uj2f, defaultjson)
  local lang2 = dpf.loadjson("langs/" .. uj2.lang .. "/trade.json", "")
  
  print("checking if u1 has i1")
  if not uj.inventory[item1] then
    if nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. mt[1] .. lang.no_item_nopeeking_2 .. lang.no_item1_nopeeking)
    else
      message.channel:send(lang.dont_have_user1_1 .. cdb[item1].name .. lang.dont_have_user1_2)
    end
    return
  end

  print("checking if u2 has i2")
  if not uj2.inventory[item2] then
    if nopeeking then
      message.channel:send(lang.no_item_nopeeking_1 .. mt[3] .. lang.no_item_nopeeking_2.. mt[2] .. lang.no_item2_nopeeking)
    else
	  if uj.lang == "ko" then
        message.channel:send(lang.dont_have_user2_1 .. mt[2] .. lang.dont_have_user2_2 .. cdb[item2].name .. lang.dont_have_user2_3 .. lang.dont_have_user2_4)
      else
        message.channel:send(lang.dont_have_user2_1 .. mt[2] .. lang.dont_have_user2_2 .. cdb[item2].name .. lang.dont_have_user2_3 .. prosel.getPronoun(uj.lang, uj2.pronouns["selection"], "their") .. lang.dont_have_user2_4)
	  end
	end
    return
  end

  print("success!!!!!")
  if uj2.lang == "ko" then
    ynbuttons(message, "<@".. uj2.id .. lang2.confirm_message_1 .. uj.id .. lang2.confirm_message_2 .. lang2.confirm_message_3 .. cdb[item1].name .. lang2.confirm_message_4 .. cdb[item2].name .. lang2.confirm_message_5, "trade", {uj2f = uj2f, item1 = item1,item2 = item2}, uj2.id, uj2.lang)
  else
    ynbuttons(message, "<@".. uj2.id .. lang2.confirm_message_1 .. uj.id .. lang2.confirm_message_2 .. prosel.getPronoun(uj2.lang, uj.pronouns["selection"], "their") .. lang2.confirm_message_3 .. cdb[item1].name .. lang2.confirm_message_4 .. cdb[item2].name .. lang2.confirm_message_5, "trade", {uj2f = uj2f, item1 = item1,item2 = item2}, uj2.id, uj2.lang)
  end
end
return command

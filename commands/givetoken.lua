local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !givetoken")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/givetoken.json","")
  if not message.guild then
    message.channel:send(lang.dm_message)
    return
  end

  if not (#mt == 1 or #mt == 2)  then
    message.channel:send(lang.no_arguments)
    return
  end

  local uj2f = usernametojson(mt[1])

  if not uj2f then
    message.channel:send(lang.no_user_1 .. mt[1] .. lang.no_user_2)
    return
  end

  local uj2 = dpf.loadjson(uj2f,defaultjson)
  local lang2 = dpf.loadjson("langs/" .. uj2.lang .. "/givetoken.json")
  if uj2.id == uj.id then
    message.channel:send(lang.same_user)
    return
  end

  local numtokens = 1
  if tonumber(mt[2]) then
    if tonumber(mt[2]) > 1 then numtokens = math.floor(tonumber(mt[2])) end
  end

  if not uj.tokens then uj.tokens = 0 end

  if mt[2] == "all" then
    numtokens = uj.tokens
  end

  if uj.tokens < numtokens then
    message.channel:send(lang.not_enough)
    return
  end

  uj.tokens = uj.tokens - numtokens
  if not uj2.tokens then uj2.tokens = 0 end
  uj2.tokens = uj2.tokens + numtokens
  
  uj.timestokengiven = uj.timestokengiven and uj.timestokengiven + numtokens or numtokens
  uj2.timestokenreceived = uj2.timestokenreceived and uj2.timestokenreceived + numtokens or numtokens
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  dpf.savejson(uj2f,uj2)

  local isplural = numtokens ~= 1 and lang.needs_plural_s == true and lang.plural_s or ""
  local isplural2 = numtokens ~= 1 and lang2.needs_plural_s == true and lang2.plural_s or ""
  
  local checktoken_isplural = uj.tokens ~= 1 and lang.needs_plural_s == true and lang.plural_s or ""
  
  if uj.lang == "ko" then
    _G['giftedmessage'] = lang.gifted_message_1 .. uj2.id .. lang.gifted_message_2 .. numtokens .. lang.gifted_message_3
    if uj.lang == uj2.lang then
	  if not uj2.togglechecktoken then
	    _G['giftedmessage'] = giftedmessage .. "\n" .. lang.checktoken2g_1 .. uj2.tokens .. lang.checktoken2g_2
	  end
	  _G['samelang'] = true
	else
	  _G['samelang'] = false
	end
	if not uj.togglechecktoken then
      _G['giftedmessage'] = giftedmessage .. "\n" .. lang.checktoken_1 .. uj.tokens .. lang.checktoken_2
	end
  else
    _G['giftedmessage'] = lang.gifted_message_1 .. numtokens .. lang.gifted_message_2 .. isplural .. lang.gifted_message_3 .. uj2.id .. lang.gifted_message_4
	if uj.lang == uj2.lang then
	  if not uj2.togglechecktoken then
	    _G['giftedmessage'] = giftedmessage .. "\n" .. lang.checktoken2g_1 .. uj2.tokens .. lang.checktoken2g_2 .. (uj2.tokens ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.checktoken2g_3 .. uj2.pronouns["their"] .. lang.checktoken2g_4	  
	  end
	  _G['samelang'] = true
	else
	  _G['samelang'] = false
	end
    if not uj.togglechecktoken then
      _G['giftedmessage'] = giftedmessage .. "\n" .. lang.checktoken_1 .. uj.tokens .. lang.checktoken_2 .. checktoken_isplural .. lang.checktoken_3
	end
  end
  if uj2.lang == "ko" then
    _G['recievedmessage'] = lang2.recieved_message_1 .. uj.id .. lang2.recieved_message_2 .. numtokens .. lang2.recieved_message_3
	if samelang ~= true then
	  if not uj2.togglechecktoken then
	    _G['recievedmessage'] = recievedmessage .. "\n" .. lang2.checktoken2r_1 .. uj2.tokens .. lang2.checktoken2r_2
      end
	end
  else
    _G['recievedmessage'] = lang2.recieved_message_1 .. uj.id .. lang2.recieved_message_2 .. numtokens .. lang2.recieved_message_3 .. isplural2 .. lang2.recieved_message_4
    if samelang ~= true then
	  if not uj2.togglechecktoken then
	    _G['recievedmessage'] = recievedmessage .. "\n" .. lang2.checktoken2r_1 .. uj2.tokens .. lang2.checktoken2r_2 .. (uj2.tokens ~= 1 and lang2.needs_plural_s == true and lang2.plural_s or "") .. lang2.checktoken2r_3
      end
	end
  end

  if samelang == true then
    message.channel:send {content = giftedmessage}
  else
    message.channel:send {content = giftedmessage .. "\n" .. recievedmessage}
  end
end
return command
  
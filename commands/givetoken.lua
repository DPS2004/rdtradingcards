local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !givetoken")
  if not message.guild then
    message.channel:send("Sorry, but you cannot give tokens in DMs!")
    return
  end

  if not (#mt == 1 or #mt == 2)  then
    message.channel:send("Sorry, but the c!givetoken command expects 1 or 2 arguments. Please see c!help for more details.")
    return
  end

  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local uj2f = usernametojson(mt[1])

  if not uj2f then
    message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    return
  end

  local uj2 = dpf.loadjson(uj2f,defaultjson)
  if uj2.id == uj.id then
    message.channel:send("Sorry, but you cannot give tokens to yourself!")
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
    message.channel:send("Sorry, but you do not have enough tokens to do that!")
    return
  end

  uj.tokens = uj.tokens - numtokens
  if not uj2.tokens then uj2.tokens = 0 end
  uj2.tokens = uj2.tokens + numtokens
  
  uj.timestokengiven = uj.timestokengiven and uj.timestokengiven + numtokens or numtokens
  uj2.timestokenreceived = uj2.timestokenreceived and uj2.timestokenreceived + numtokens or numtokens
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  dpf.savejson(uj2f,uj2)

  message.channel:send {
    content = 'You have gifted ' .. numtokens .. ' **Token' .. (numtokens == 1 and "" or "s") ..'** to <@' .. uj2.id .. '>.'}
  if not uj.togglechecktoken then
    message.channel:send('You currently have ' .. uj.tokens .. ' **Token' .. (uj.tokens == 1 and "" or "s") .. '** left.')
  end
end
return command
  
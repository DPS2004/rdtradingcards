local command = {}
function command.run(message, mt)
  local cmember = message.guild:getMember(message.author)
  if cmember:hasRole(privatestuff.modroleid) then
    if usernametojson(mt[1]) then
      local uj = dpf.loadjson(usernametojson(mt[1]),defaultjson)
      local numtokens = 1
      if tonumber(mt[2]) then
        if tonumber(mt[2]) > 1 then
          numtokens = math.floor(tonumber(mt[2]))
        end
      end
      if not uj.tokens then
        uj.tokens = numtokens
      else
        uj.tokens = uj.tokens + numtokens
      end
      dpf.savejson(usernametojson(mt[1]),uj)
      local isplural = " Token has "
      if numtokens ~= 1 then
        isplural = " Tokens have "
      end
      message.channel:send(numtokens .. isplural .. "been given to " .. mt[1] .. ".")
    else
      message.channel:send("Sorry, but I could not find a user named " .. mt[1] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
    end
  else
    message.channel:send("haha no, nice try")
  end
end
return command
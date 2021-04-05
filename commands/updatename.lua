local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  print(message.author.name .. " did !updatename")
  if mt[1] == "" then
    mt[1] = nil
  end
  if mt[1] then
    if mt[1] ~= uj.name and mt[1] ~= uj.id then
      if not usernametojson(mt[1]) then
        uj.name = mt[1]
        message.channel:send("Your name for trading and gifting has now been changed to " .. uj.name .. "!")
      else
        message.channel:send("Sorry, but someone else is already using that name.")
      end
    elseif mt[1] == uj.id then
      message.channel:send("You cannot use your ID as your name!")
    else
      message.channel:send("Your name is already " .. uj.name .. "!")
    end
    
  else
    uj.name = message.author.name .. "#".. message.author.discriminator
    message.channel:send("Your name for trading and gifting has now been changed to " .. uj.name .. "!")
  end
  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  
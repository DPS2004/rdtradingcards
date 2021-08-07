local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  print(message.author.name .. " did !nickname")
  local maxnicknames = 4
  
  if not uj.names then
    uj.names = {}
    uj.names[message.author.name .. "#" .. message.author.discriminator] = true
    dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
  end

  local numnames = 0
  for k in pairs(uj.names) do
    numnames = numnames + 1
  end

  if mt[1] == "" then
    mt[1] = "check"
    mt[2] = uj.id
  end
  
  if mt[1] == "add" then
    if not mt[2] then
      message.channel:send("Please input a nickname to add.")
      return
    end

    if mt[2] == uj.id then
      message.channel:send("You cannot set your ID as a nickname!")
      return
    end

    if usernametojson(mt[2]) then
      if string.find(usernametojson(mt[2]), uj.id, 10) then
        message.channel:send("You already have " .. mt[2] .. " as a nickname!")
      else
        message.channel:send("Sorry, but someone else is already using that name.")
      end
      return
    end

    if string.sub(mt[2], 1, 1) == "<" and string.sub(mt[2], #mt[2], #mt[2]) == ">" then
      message.channel:send("Sorry, but that is not a valid nickname.")
      return
    end

    if numnames >= maxnicknames then
      message.channel:send("Sorry, but you cannot have more than " .. maxnicknames .. " nicknames.")
      return
    end

    uj.names[mt[2]] = true
    message.channel:send("You have added " .. mt[2] .. " as your trading and gifting nickname!")
  elseif mt[1] == "remove" then
    if not mt[2] then
      message.channel:send("Please input a nickname to remove.")
      return
    end

    if numnames == 1 then
      message.channel:send("You need to have at least 1 nickname!")
      return
    end

    if not uj.names[mt[2]] then
      message.channel:send("You do not have " .. mt[2] .. " as a nickname. Make sure that you spelled it right!")
      return
    end

    uj.names[mt[2]] = nil
    message.channel:send("You have removed " .. mt[2] .. " as a trading and gifting nickname!")
  elseif mt[1] == "reset" then
    uj.names = {}
    uj.names[message.author.name .. "#" .. message.author.discriminator] = true
    message.channel:send("Your nickname for trading and gifting has been reset to " .. message.author.name .. "#" .. message.author.discriminator .. "!")
  elseif mt[1] == "check" then
    local nicknamestring = ""
    if not mt[2] then
      mt[2] = uj.id
    end

    local uj2f = usernametojson(mt[2])
    if not uj2f then
      message.channel:send("Sorry, but I could not find a user named " .. mt[2] .. " in the database. Make sure that you have spelled it right, and that they have at least pulled a card to register!")
      return
    end

    local uj2 = dpf.loadjson(uj2f,defaultjson)
    for k in pairs(uj2.names) do
      nicknamestring = nicknamestring .. k .. "/"
    end
    nicknamestring = nicknamestring:sub(1, -2)

    if string.find(uj2f, uj.id, 10) then
      if numnames == 1 then
        message.channel:send("Your nickname for trading and gifting is " .. nicknamestring)
      else
        message.channel:send("Your nicknames for trading and gifting are " .. nicknamestring)
      end
    else
      local numnames2 = 0
      for k in pairs(uj2.names) do numnames2 = numnames2 + 1 end
      if numnames2 == 1 then
        message.channel:send(nicknamestring .. " is " .. uj2.pronouns["their"] .. " only name for trading and gifting.")
      else
        message.channel:send(mt[2] .. "'s nicknames for trading and gifting are " .. nicknamestring)
      end
    end
  else
    message.channel:send("Sorry, but I do not recognize " .. mt[1] .. " as a valid nickname command.")
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command

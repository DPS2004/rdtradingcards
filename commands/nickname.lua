local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  print(message.author.name .. " did !nickname")
  local maxnicknames = 3

  local numnames = 0
  for k,v in pairs(uj.names) do
    numnames = numnames + 1
  end

  if mt[1] == "" then
    local nicknamestring = ""
    for k,v in pairs(uj.names) do
      nicknamestring = nicknamestring .. k .. "/"
    end
    nicknamestring = nicknamestring:sub(1, -2)
    if numnames == 1 then
      message.channel:send("Your nickname for trading and gifting is " .. nicknamestring)
    else
      message.channel:send("Your nicknames for trading and gifting are " .. nicknamestring)
    end
  elseif mt[1] == "add" then
    if mt[2] then
      if not usernametojson(mt[2]) then
        if mt[2] ~= uj.id then
          if numnames < maxnicknames then
            uj.names[mt[2]] = true
            message.channel:send("You have added " .. mt[2] .. " as your trading and gifting nickname!")
          else
            message.channel:send("Sorry, but you cannot have more than " .. maxnicknames .. " nicknames.")
          end
        else
          message.channel:send("You cannot set your ID as a nickname!")
        end
      elseif string.find(usernametojson(mt[2]), uj.id, 10) then
        message.channel:send("You already have " .. mt[2] .. " as a nickname!")
      else
        message.channel:send("Sorry, but someone else is already using that name.")
      end
    end
  elseif mt[1] == "remove" then
    if mt[2] then
      if(numnames ~= 1) then
        if uj.names[mt[2]] then
          uj.names[mt[2]] = nil
          message.channel:send("You have removed " .. mt[2] .. " as a trading and gifting nickname!")
        else
          message.channel:send("You do not have " .. mt[2] .. " as a nickname. Make sure that you spelled it right!")
        end
      else
        message.channel:send("You need to have at least 1 nickname!")
      end
    end
  elseif mt[1] == "reset" then
    uj.names = {}
    uj.names[message.author.name .. "#" .. message.author.discriminator] = true
    message.channel:send("Your nickname for trading and gifting has been reset to " .. message.author.name .. "#" .. message.author.discriminator .. "!")
  -- elseif mt[1] == "check" then
  --   todo: add nickname check functionality
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command
  
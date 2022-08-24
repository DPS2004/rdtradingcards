local command = {}
function command.run(message, mt)
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/nickname.json","")
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
      message.channel:send(lang.add_nothing)
      return
    end

    if mt[2] == uj.id then
      message.channel:send(lang.add_id)
      return
    end

    if usernametojson(mt[2]) then
      if string.find(usernametojson(mt[2]), uj.id, 10) then
        message.channel:send(lang.add_already_1 .. mt[2] .. lang.add_already_2)
      else
        message.channel:send(lang.add_other_user)
      end
      return
    end

    if string.sub(mt[2], 1, 1) == "<" and string.sub(mt[2], #mt[2], #mt[2]) == ">" then
      message.channel:send(lang.add_invalid)
      return
    end

    if numnames >= maxnicknames then
      message.channel:send(lang.add_too_many_1 .. maxnicknames .. lang.add_too_many_2)
      return
    end

    uj.names[mt[2]] = true
    message.channel:send(lang.add_success_1 .. mt[2] .. lang.add_success_2)
  elseif mt[1] == "remove" then
    if not mt[2] then
      message.channel:send(lang.remove_nothing)
      return
    end

    if numnames == 1 then
      message.channel:send(lang.remove_least_one)
      return
    end

    if not uj.names[mt[2]] then
      message.channel:send(lang.remove_no_such_1 .. mt[2] .. lang.remove_no_such_2)
      return
    end

    uj.names[mt[2]] = nil
    message.channel:send(lang.remove_success_1 .. mt[2] .. lang.remove_success_2)
  elseif mt[1] == "reset" then
    uj.names = {}
    uj.names[message.author.name .. "#" .. message.author.discriminator] = true
    message.channel:send(lang.reset_success_1 .. message.author.name .. "#" .. message.author.discriminator .. lang.reset_success_2)
  elseif mt[1] == "check" then
    local nicknamestring = ""
    if not mt[2] then
      mt[2] = uj.id
    end

    local uj2f = usernametojson(mt[2])
    if not uj2f then
      message.channel:send(lang.check_no_user_1 .. mt[2] .. lang.check_no_user_2)
      return
    end

    local uj2 = dpf.loadjson(uj2f,defaultjson)
    for k in pairs(uj2.names) do
      nicknamestring = nicknamestring .. k .. "/"
    end
    nicknamestring = nicknamestring:sub(1, -2)

    if string.find(uj2f, uj.id, 10) then
      if numnames == 1 then
        message.channel:send(lang.check_yourself_singular .. nicknamestring)
      else
        message.channel:send(lang.check_yourself_plural .. nicknamestring)
      end
    else
      local numnames2 = 0
      for k in pairs(uj2.names) do numnames2 = numnames2 + 1 end
      if numnames2 == 1 then
        message.channel:send(nicknamestring .. lang.check_other_singular_1 .. (uj.lang ~= "ko" and uj2.pronouns["their"]) .. lang.check_other_singular_2)
      else
        message.channel:send(mt[2] .. lang.check_other_plural .. nicknamestring)
      end
    end
  else
    message.channel:send(lang.invalid_command_1 .. mt[1] .. lang.invalid_command_2)
  end

  dpf.savejson("savedata/" .. message.author.id .. ".json",uj)
end
return command

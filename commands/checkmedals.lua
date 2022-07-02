local command = {}
function command.run(message)
  print("checking medals for " .. message.author.name)

  local ujf = ("savedata/" .. message.author.id .. ".json")
  local uj = dpf.loadjson(ujf, defaultjson)

  for i, v in ipairs(medalrequires) do
    print("checking " .. v.receive)

    if not v.require(uj) then
      print("user cannot have " .. v.receive)
      uj.medals[v.receive] = false
      goto continue
    end

    print("user can have " .. v.receive)

    if uj.medals[v.receive] then
      print("user already has " .. v.receive)
      goto continue
    end

    print("user does not have it yet!")

    uj.medals[v.receive] = true

    message.channel:send { embed = {
      color = 0x85c5ff,
      title = "Congratulations!",
      description = 'After collecting and storing some cards, ' .. message.author.mentionString .. ' got the **"' .. medaldb[v.receive].name .. '"** medal!',
      image = { url = medaldb[v.receive].embed }
    } }

    if v.receive == 'cardmaestro' then
      message.channel:send("You also unlocked the ability to use **c!prestige**.")
    end

    ::continue::
  end

  dpf.savejson(ujf, uj)
end

return command

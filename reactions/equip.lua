local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local newequip = eom.newequip
  local uj = dpf.loadjson(ujf, defaultjson)
  local time = sw:getTime()
  print("Loaded uj")

  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  client:emit(reaction.message.id)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    if uj.lastequip + 6 > time:toHours() then
      reaction.message.channel:send("An error has occured. Please make sure that you didn't recently equip another item!")
      return
    end

    uj.equipped = newequip
    reaction.message.channel:send("<@" .. uj.id .. "> successfully set **" .. itemdb[newequip].name .. "** as " .. uj.pronouns["their"] .. " equipped item.")
    uj.lastequip = time:toHours()
    dpf.savejson(ujf, uj)
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("<@" .. uj.id .. "> has successfully stopped the changing of " .. uj.pronouns["their"] .. " equipped item.")
  end
end
return reaction

local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  print('It is a trade message being reacted to')
  local ujf = eom.ujf
  local uj2f = eom.uj2f
  local item1 = eom.item1
  local item2 = eom.item2
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")
  local uj2 = dpf.loadjson(uj2f, defaultjson)
  print("Loaded uj2")
  if uj2.id ~= userid then
    print("It's not uj2 reacting")
    return
  end

  print('user2 has reacted')
  client:emit(reaction.message.id)

  if reaction.emojiName == "✅" then
    print('user2 has accepted')
    if not (uj.inventory[item1] and uj2.inventory[item2]) then
      reaction.message.channel:send("An error has occured. Please make sure that both parties still have the cards in their inventories!")
      return
    end

    print("Removing item1 from user1")
    uj.inventory[item1] = uj.inventory[item1] - 1
    if uj.inventory[item1] == 0 then uj.inventory[item1] = nil end
    print("Removing item2 from user2")
    uj2.inventory[item2] = uj2.inventory[item2] - 1
    if uj2.inventory[item2] == 0 then uj2.inventory[item2] = nil end

    print("Giving item1 to user2")
    uj2.inventory[item1] = uj2.inventory[item1] and uj2.inventory[item1] + 1 or 1
    print("Giving item2 to user1")
    uj.inventory[item2] = uj.inventory[item2] and uj.inventory[item2] + 1 or 1

    uj.timestraded = uj.timestraded and uj.timestraded + 1 or 1
    uj2.timestraded = uj2.timestraded and uj2.timestraded + 1 or 1
    
    reaction.message.channel:send("The trade between <@".. uj2.id .."> and <@" .. uj.id .. "> has completed.")
    dpf.savejson(uj2f,uj2)
    dpf.savejson(ujf,uj)
  end

  if reaction.emojiName == "❌" then
    print('user2 has denied')
    reaction.message.channel:send("<@".. uj2.id .."> has successfully denied the trade with <@" .. uj.id .. ">.")
  end
end
return reaction

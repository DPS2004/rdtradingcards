local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local item1 = eom.item1
  local numcards = eom.numcards
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")
  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  dpf.savejson("savedata/events.json", ef)
  ef[reaction.message.id] = nil

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    if not uj.inventory[item1] then
      reaction.message.channel:send("An error has occured. Please make sure that you still have the card in your inventory!")
      return
    end

    if uj.inventory[item1] < numcards then
      reaction.message.channel:send("An error has occured. Please make sure that you still have enough **" .. fntoname(item1) .. "** cards in your inventory!")
      return
    end

    print("Removing item1 from user1")
    uj.inventory[item1] = uj.inventory[item1] - numcards
    if uj.inventory[item1] == 0 then uj.inventory[item1] = nil end

    print("Giving item1 to user1 storage")
    uj.storage[item1] = uj.storage[item1] and uj.storage[item1] + numcards or numcards

    uj.timesstored = uj.timesstored and uj.timesstored + numcards or numcards

    reaction.message.channel:send("<@" .. uj.id .. "> successfully put " .. uj.pronouns["their"] .. " " .. numcards .. " **" .. fntoname(item1) .. "** card" .. (numcards == 1 and "" or "s") .. " into storage.")
    dpf.savejson(ujf,uj)
    cmd.checkcollectors.run(eom.ogmessage,mt,reaction.message.channel)
    cmd.checkmedals.run(eom.ogmessage,mt,reaction.message.channel)
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("<@" .. uj.id .. "> has successfully stopped the storage of " .. uj.pronouns["their"] .. " **" .. fntoname(item1) .. "** card" .. (numcards == 1 and "" or "s") .. ".")
  end
end
return reaction

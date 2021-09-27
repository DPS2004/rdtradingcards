local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local curfilename = eom.curfilename
  local numcards = eom.numcards
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  client:emit(reaction.message.id)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    if not uj.inventory[curfilename] then
      reaction.message.channel:send("An error has occured. Please make sure that you still have the card in your inventory!")
      return
    end

    if uj.inventory[curfilename] < numcards then
      reaction.message.channel:send("An error has occured. Please make sure that you still have enough **" .. cdb[curfilename].name .. "** cards in your inventory!")
      return
    end

    print("Removing item1 from user1")
    uj.inventory[curfilename] = uj.inventory[curfilename] - numcards
    if uj.inventory[curfilename] == 0 then uj.inventory[curfilename] = nil end

    uj.timesshredded = uj.timesshredded and uj.timesshredded + numcards or numcards

    reaction.message.channel:send("<@" .. uj.id .. "> successfully shredded " .. uj.pronouns["their"] .. " " .. numcards .. " **" .. cdb[curfilename].name .. "** card" .. (numcards == 1 and "" or "s") .. ".")

    dpf.savejson(ujf, uj)
    cmd.checkmedals.run(eom.ogmessage, {}, reaction.message.channel)
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("<@" .. uj.id .. "> has successfully stopped the shredding of " .. uj.pronouns["their"] .. " **" .. cdb[curfilename].name .. "** card" .. (numcards == 1 and "" or "s").. ".")
  end
end
return reaction

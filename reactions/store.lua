local reaction = {}
function reaction.run(message, interaction, data, response)
  local item1 = data.item1
  local numcards = data.numcards
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    if not uj.inventory[item1] then
      interaction:reply("An error has occured. Please make sure that you still have the card in your inventory!")
      return
    end

    if uj.inventory[item1] < numcards then
      interaction:reply("An error has occured. Please make sure that you still have enough **" .. cdb[item1].name .. "** cards in your inventory!")
      return
    end

    print("Removing item1 from user1")
    uj.inventory[item1] = uj.inventory[item1] - numcards
    if uj.inventory[item1] == 0 then uj.inventory[item1] = nil end

    print("Giving item1 to user1 storage")
    uj.storage[item1] = uj.storage[item1] and uj.storage[item1] + numcards or numcards

    uj.timesstored = uj.timesstored and uj.timesstored + numcards or numcards

    interaction:reply("<@" .. uj.id .. "> successfully put " .. uj.pronouns["their"] .. " " .. numcards .. " **" .. cdb[item1].name .. "** card" .. (numcards == 1 and "" or "s") .. " into storage.")
    dpf.savejson(ujf,uj)
    cmd.checkcollectors.run(message, {}, message.channel)
    cmd.checkmedals.run(message, {}, message.channel)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply("<@" .. uj.id .. "> has successfully stopped the storage of " .. uj.pronouns["their"] .. " **" .. cdb[item1].name .. "** card" .. (numcards == 1 and "" or "s") .. ".")
  end
end
return reaction

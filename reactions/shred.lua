local reaction = {}
function reaction.run(message, interaction, data, response)
  local curfilename = data.curfilename
  local numcards = data.numcards
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')

    if not uj.inventory[curfilename] then
      interaction:reply("An error has occured. Please make sure that you still have the card in your inventory!")
      return
    end

    if uj.inventory[curfilename] < numcards then
      interaction:reply("An error has occured. Please make sure that you still have enough **" .. cdb[curfilename].name .. "** cards in your inventory!")
      return
    end

    print("Removing item1 from user1")
    uj.inventory[curfilename] = uj.inventory[curfilename] - numcards
    if uj.inventory[curfilename] == 0 then uj.inventory[curfilename] = nil end

    uj.timesshredded = uj.timesshredded and uj.timesshredded + numcards or numcards

    interaction:reply("<@" .. uj.id .. "> successfully shredded " .. uj.pronouns["their"] .. " " .. numcards .. " **" .. cdb[curfilename].name .. "** card" .. (numcards == 1 and "" or "s") .. ".")

    dpf.savejson(ujf, uj)
    cmd.checkmedals.run(message, {}, message.channel)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply("<@" .. uj.id .. "> has successfully stopped the shredding of " .. uj.pronouns["their"] .. " **" .. cdb[curfilename].name .. "** card" .. (numcards == 1 and "" or "s").. ".")
  end
end
return reaction

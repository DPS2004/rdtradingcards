local reaction = {}
function reaction.run(message, interaction, data, response)
  local item1 = data.item1
  local numcards = data.numcards
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/store.json", "")
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    if not uj.inventory[item1] then
      interaction:reply(lang.reaction_dont_have)
      return
    end

    if uj.inventory[item1] < numcards then
      interaction:reply(lang.reaction_not_enough_1 .. cdb[item1].name .. lang.reaction_not_enough_2)
      return
    end

    print("Removing item1 from user1")
    uj.inventory[item1] = uj.inventory[item1] - numcards
    if uj.inventory[item1] == 0 then uj.inventory[item1] = nil end

    print("Giving item1 to user1 storage")
    uj.storage[item1] = uj.storage[item1] and uj.storage[item1] + numcards or numcards

    uj.timesstored = uj.timesstored and uj.timesstored + numcards or numcards

	if uj.lang == "ko" then
		interaction:reply(lang.stored_message_1 .. uj.id .. lang.stored_message_2 .. lang.stored_message_3 .. lang.stored_message_4 .. cdb[item1].name .. lang.stored_message_5 .. numcards .. lang.stored_message_6)
	else
		interaction:reply(lang.stored_message_1 .. uj.id .. lang.stored_message_2 .. uj.pronouns["their"] .. lang.stored_message_3 .. numcards .. lang.stored_message_4 .. cdb[item1].name .. lang.stored_message_5 .. (numcards == 1 and "" or lang.needs_plural_s == "true" and lang.plural_s) .. lang.stored_message_6)
    end
    dpf.savejson(ujf,uj)
    cmd.checkcollectors.run(message, {}, message.channel)
    cmd.checkmedals.run(message, {}, message.channel)
  end

  if response == "no" then
    print('user1 has denied')
	if uj.lang == "ko" then
		interaction:reply(lang.reaction_stopped_1 .. uj.id .. lang.reaction_stopped_2 .. lang.reaction_stopped_3 .. cdb[item1].name .. lang.reaction_stopped_4 .. lang.reaction_stopped_5)
    else
		interaction:reply(lang.reaction_stopped_1 .. uj.id .. lang.reaction_stopped_2 .. uj.pronouns["their"] .. lang.reaction_stopped_3 .. cdb[item1].name .. lang.reaction_stopped_4 .. (numcards == 1 and "" or lang.needs_plural_s == "true" and lang.plural_s) .. lang.reaction_stopped_5)
	end
  end
end
return reaction

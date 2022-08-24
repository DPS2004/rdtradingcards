local reaction = {}
function reaction.run(message, interaction, data, response)
  local curfilename = data.curfilename
  local numcards = data.numcards
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/shred.json", "")
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')

    if not uj.inventory[curfilename] then
      interaction:reply(lang.reaction_dont_have)
      return
    end

    if uj.inventory[curfilename] < numcards then
      interaction:reply(lang.reaction_not_enough_1 .. cdb[curfilename].name .. lang.reaction_not_enough_2)
      return
    end

    print("Removing item1 from user1")
    uj.inventory[curfilename] = uj.inventory[curfilename] - numcards
    if uj.inventory[curfilename] == 0 then uj.inventory[curfilename] = nil end

    uj.timesshredded = uj.timesshredded and uj.timesshredded + numcards or numcards

    if uj.lang == "ko" then
		interaction:reply(lang.shredded_message_1 .. uj.id .. lang.shredded_message_2 .. cdb[curfilename].name .. lang.shredded_message_3 .. numcards .. lang.shredded_message_4)
	else
		interaction:reply(lang.shredded_message_1 .. uj.id .. lang.shredded_message_2 .. uj.pronouns["their"] .. lang.shredded_message_3 .. numcards .. lang.shredded_message_4 .. cdb[curfilename].name .. lang.shredded_message_5 .. (numcards ~= 1 and lang.needs_plural_s == true and lang.plural_s or "") .. lang.shredded_message_6)
	end
    dpf.savejson(ujf, uj)
    cmd.checkmedals.run(message, {}, message.channel)
  end

  if response == "no" then
    print('user1 has denied')
    if uj.lang == "ko" then
		interaction:reply(lang.denied_message_1 .. uj.id .. lang.denied_message_2 .. cdb[curfilename].name .. lang.denied_message_3)
	else
		interaction:reply(lang.denied_message_1 .. uj.id .. lang.denied_message_2 .. uj.pronouns["their"] .. lang.denied_message_3 .. cdb[curfilename].name .. lang.denied_message_4 .. (numcards ~= 1 and lang.needs_plural_s == true and lang.plural_s or "").. lang.denied_message_5)
	end
  end
end
return reaction

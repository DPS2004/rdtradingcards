local reaction = {}
function reaction.run(message, interaction, data, response)
  print('It is a trade message being reacted to')
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj2f = data.uj2f
  local item1 = data.item1
  local item2 = data.item2
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/trade.json", "")
  print("Loaded uj")
  local uj2 = dpf.loadjson(uj2f, defaultjson)
  local lang2 = dpf.loadjson("langs/" .. uj2.lang .. "/trade.json", "")
  print("Loaded uj2")

  if response == "yes" then
    print('user2 has accepted')
    if not (uj.inventory[item1] and uj2.inventory[item2]) then
	  if uj.lang == uj2.lang then
        interaction:reply(lang.reaction_no_card)
	  else
	    interaction:reply(lang.reaction_no_card .. "\n" .. lang2.reaction_no_card)
	  end
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
    
	if uj.lang == uj2.lang then
      interaction:reply(lang.reaction_trade_done_1 .. uj2.id .. lang.reaction_trade_done_2 .. uj.id .. lang.reaction_trade_done_3)
    else
	  interaction:reply(lang.reaction_trade_done_1 .. uj2.id .. lang.reaction_trade_done_2 .. uj.id .. lang.reaction_trade_done_3 .. "\n" .. lang2.reaction_trade_done_1 .. uj2.id .. lang2.reaction_trade_done_2 .. uj.id .. lang2.reaction_trade_done_3)
	end
	dpf.savejson(uj2f,uj2)
    dpf.savejson(ujf,uj)
  end

  if response == "no" then
    print('user2 has denied')
    if uj.lang == uj2.lang then
	  interaction:reply(lang.reaction_trade_denied_1 .. uj2.id .. lang.reaction_trade_denied_2 .. uj.id .. lang.reaction_trade_denied_3)
    else
	  interaction:reply(lang.reaction_trade_denied_1 .. uj2.id .. lang.reaction_trade_denied_2 .. uj.id .. lang.reaction_trade_denied_3 .. "\n" .. lang2.reaction_trade_denied_1 .. uj2.id .. lang2.reaction_trade_denied_2 .. uj.id .. lang2.reaction_trade_denied_3)
    end
  end
end
return reaction

local reaction = {}
function reaction.run(message, interaction, data, response)
  local newequip = data.newequip
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/equip.json", "")
  local time = sw:getTime()
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    if uj.lastequip + 6 > time:toHours() then
      interaction:reply(lang.reaction_not_cooldown)
      return
    end

    uj.equipped = newequip
    if uj.lang == "ko" then
	    message.channel:send("<@" .. uj.id .. "> " .. lang.equipped_1 .. itemdb[newequip].name .. lang.equipped_2 .. lang.equipped_3)
    else
	    message.channel:send("<@" .. uj.id .. "> " .. lang.equipped_1 .. itemdb[newequip].name .. lang.equipped_2 ..uj.pronouns["their"].. lang.equipped_3)
	end
	uj.lastequip = time:toHours()

    if uj.sodapt and uj.sodapt.equip then
      uj.lastequip = uj.lastequip + uj.sodapt.equip
      uj.sodapt.equip = nil
      if uj.sodapt == {} then uj.sodapt = nil end
    end
    
    dpf.savejson(ujf, uj)
  end

  if response == "no" then
    print('user1 has denied')
    if uj.lang == "ko" then
	  interaction:reply("<@" .. uj.id .. "> " .. lang.stopped_1 .. lang.stopped_2)
	else
	  interaction:reply("<@" .. uj.id .. "> " .. lang.stopped_1 .. uj.pronouns["their"] .. lang.stopped_2)
	end
  end
end
return reaction

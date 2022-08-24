local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/lab/box.json", "")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local time = sw:getTime()
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    local cooldown = (uj.equipped == "stainedgloves") and 8 or 11.5
    if uj.lastbox + cooldown > time:toHours() then
      interaction:reply(lang.reaction_not_cooldown)
      return
    end

    if not next(uj.inventory) then
      interaction:reply(lang.reaction_no_card)
      return
    end

    local iptable = {}
    for k, v in pairs(uj.inventory) do
      for i = 1, v do
        table.insert(iptable, k)
      end
    end

    local givecard = iptable[math.random(#iptable)]
    print("user giving " .. givecard)
    local boxpoolindex = math.random(#wj.boxpool)
    local getcard = wj.boxpool[boxpoolindex]
    
    uj.inventory[getcard] = uj.inventory[getcard] and uj.inventory[getcard] + 1 or 1
    uj.inventory[givecard] = uj.inventory[givecard] - 1
    if uj.inventory[givecard] == 0 then uj.inventory[givecard] = nil end
    
    wj.boxpool[boxpoolindex] = givecard
    
    if uj.lang == "ko" then
      message.channel:send(lang.boxed_message_1 .. uj.id .. lang.boxed_message_2 .. cdb[givecard].name .. lang.boxed_message_3 .. cdb[getcard].name .. lang.boxed_message_4 .. getcard .. lang.boxed_message_5)
	else
	  message.channel:send(lang.boxed_message_1 .. uj.id .. lang.boxed_message_2 .. cdb[givecard].name .. lang.boxed_message_3 .. uj.pronouns["their"] .. lang.boxed_message_4 .. cdb[getcard].name .. lang.boxed_message_5 .. uj.pronouns["their"] .. lang.boxed_message_6 .. getcard .. lang.boxed_message_7)
	end
	
	if not uj.togglecheckcard then
            if not uj.storage[getcard] then
                message.channel:send(lang.not_in_storage_1 .. cdb[getcard].name .. lang.not_in_storage_2)
            end
        end
    uj.timesusedbox = uj.timesusedbox and uj.timesusedbox + 1 or 1
    uj.lastbox = time:toHours()
    
    if uj.sodapt then
      if uj.sodapt.box then
        uj.lastbox = uj.lastbox + uj.sodapt.box
        uj.sodapt.box = nil
        if uj.sodapt == {} then
          uj.sodapt = nil
        end
      end
    end
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/worldsave.json", wj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.reaction_stopped)
  end
end
return reaction

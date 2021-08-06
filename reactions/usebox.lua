local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local uj = dpf.loadjson(ujf, defaultjson)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local time = sw:getTime()
  print("Loaded uj")
  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  ef[reaction.message.id] = nil
  dpf.savejson("savedata/events.json", ef)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    local cooldown = (uj.equipped == "stainedgloves") and 8 or 11.5
    if uj.lastbox + cooldown > time:toHours() then
      reaction.message.channel:send("An error has occurred. Please make sure that you didn't recently use the box!")
      return
    end

    if not next(uj.inventory) then
      reaction.message.channel:send("An error has occured. Please make sure that you still have a card in your inventory!")
      return
    end

    local iptable = {}
    for k, v in pairs(uj.inventory) do
      for i = 1, v do
        table.insert(iptable, k)
      end
    end

    local givecard = iptable[math.random(1,#iptable)]
    print("user giving " .. givecard)
    local boxpoolindex = math.random(1,#wj.boxpool)
    local getcard = wj.boxpool[boxpoolindex]
    
    uj.inventory[getcard] = uj.inventory[getcard] and uj.inventory[getcard] + 1 or 1
    uj.inventory[givecard] = uj.inventory[givecard] - 1
    if uj.inventory[givecard] == 0 then uj.inventory[givecard] = nil end
    
    wj.boxpool[boxpoolindex] = givecard
    
    reaction.message.channel:send('<@' .. uj.id .. '> grabs a **' .. fntoname(givecard) .. '** card from '..uj.pronouns["their"]..' inventory and places it inside the box. As it goes in, a **' .. fntoname(getcard) .. '** card shows up in '..uj.pronouns["their"]..' pocket!')

    uj.timesusedbox = uj.timesusedbox and uj.timesusedbox + 1 or 1
    uj.lastbox = time:toHours()
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/worldsave.json", wj)
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("You decide to not put a **Trading Card** in the **Peculiar Box**.")
  end
end
return reaction

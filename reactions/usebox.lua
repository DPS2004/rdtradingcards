local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local time = sw:getTime()
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    local cooldown = (uj.equipped == "stainedgloves") and 8 or 11.5
    if uj.lastbox + cooldown > time:toHours() then
      interaction:reply("An error has occurred. Please make sure that you didn't recently use the box!")
      return
    end

    if not next(uj.inventory) then
      interaction:reply("An error has occured. Please make sure that you still have a card in your inventory!")
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
    
    interaction:reply('<@' .. uj.id .. '> grabs a **' .. cdb[givecard].name .. '** card from '..uj.pronouns["their"]..' inventory and places it inside the box. As it goes in, a **' .. cdb[getcard].name .. '** card shows up in '..uj.pronouns["their"]..' pocket! The shorthand form of this card is **' .. getcard .. '**.')

        if not uj.checkcard then
            if not uj.storage[getcard] then
                message.channel:send('You do not have the **' .. cdb[getcard].name .. '** card in your storage!')
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
    interaction:reply("You decide to not put a **Trading Card** in the **Peculiar Box**.")
  end
end
return reaction

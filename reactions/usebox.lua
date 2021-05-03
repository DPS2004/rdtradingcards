reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local newequip = eom.newequip
  local uj = dpf.loadjson(ujf, defaultjson)
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  local time = sw:getTime()
  print("loaded uj")
  if uj.id == userid then
    print('user1 has reacted')
    
    if reaction.emojiName == "✅" then
      print('user1 has accepted')
      local iptable = {}
      for k,v in pairs(uj.inventory) do
        table.insert(iptable, k)
      end
      local givecard = iptable[math.random(1,#iptable)]
      print("user giving " .. givecard)
      
      local boxpoolindex = math.random(1,#wj.boxpool)
      local getcard = wj.boxpool[boxpoolindex]
      
      if uj.inventory[getcard] == nil then
        uj.inventory[getcard] = 1
      else
        uj.inventory[getcard] = uj.inventory[getcard] + 1
      end
      
      uj.inventory[givecard] = uj.inventory[givecard] - 1
      
      if uj.inventory[givecard] == 0 then
        uj.inventory[givecard] = nil
      end
      
      wj.boxpool[boxpoolindex] = givecard
      
      local newmessage = reaction.message.channel:send {
        content = 'You grab a **' .. fntoname(givecard) .. '** card from your inventory, and place it inside the box. As it goes in, a **' .. fntoname(getcard) .. '** card shows up in your pocket!'
      }
      
      if uj.timesusedbox == nil then
        uj.timesusedbox = 1
      else
        uj.timesusedbox = uj.timesusedbox + 1
      end
      
      dpf.savejson(ujf,uj)
      ef[reaction.message.id] = nil
      
      dpf.savejson("savedata/events.json",ef)
      dpf.savejson("savedata/worldsave.json", wj)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      
      local newmessage = reaction.message.channel:send("You decide to not put a **Trading Card** in the **Peculiar Box**.")
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  
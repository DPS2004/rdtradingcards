reaction = {}
function reaction.run(ef, eom, reaction, userid)
  print('it is a trade message being reacted to')
  local ujf = eom.ujf
  local uj2f = eom.uj2f
  local item1 = eom.item1
  local item2 = eom.item2
  local uj = dpf.loadjson(ujf, defaultjson)
  print("loaded uj")
  local uj2 = dpf.loadjson(uj2f, defaultjson)
  print("loaded uj2")
  if uj2.id == userid then
    print('user2 has reacted')
    if reaction.emojiName == "✅" then
      print('user2 has accepted')
      print("removing item1 from user1")
      uj.inventory[item1] = uj.inventory[item1] - 1
      if uj.inventory[item1] == 0 then
        uj.inventory[item1] = nil
      end
      print("removing item2 from user2")
      uj2.inventory[item2] = uj2.inventory[item2] - 1
      if uj2.inventory[item2] == 0 then
        uj2.inventory[item2] = nil
      end
      print("giving item1 to user2")
      if uj2.inventory[item1] == nil then
        uj2.inventory[item1] = 1
      else
        uj2.inventory[item1] = uj2.inventory[item1] + 1
      end        
      print("giving item2 to user1")
      if uj.inventory[item2] == nil then
        uj.inventory[item2] = 1
      else
        uj.inventory[item2] = uj.inventory[item2] + 1
      end
      
      ef[reaction.message.id] = nil
      reaction.message.channel:send("The trade between <@".. uj2.id .."> and <@" .. uj.id .. "> has completed.")
      dpf.savejson("savedata/events.json",ef)
      dpf.savejson(uj2f,uj2)
      dpf.savejson(ujf,uj)
    end
    if reaction.emojiName == "❌" then
      print('user2 has denied')
      ef[reaction.message.id] = nil
      local newmessage = reaction.message.channel:send("<@".. uj2.id .."> has successfully denied the trade with <@" .. uj.id .. ">.")
      dpf.savejson("savedata/events.json",ef)
      
    end
  else
    print("its not uj2 reacting")
  end
end
return reaction
  
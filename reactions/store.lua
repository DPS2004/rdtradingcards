reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local item1 = eom.item1
  local uj = dpf.loadjson(ujf, defaultjson)
  print("loaded uj")
  if uj.id == userid then
    print('user1 has reacted')
    if reaction.emojiName == "✅" then
      print('user1 has accepted')
      if uj.inventory[item1] then
        print("removing item1 from user1")
        uj.inventory[item1] = uj.inventory[item1] - 1
        if uj.inventory[item1] == 0 then
          uj.inventory[item1] = nil
        end     
        print("giving item1 to user1 storage")
        if uj.storage[item1] == nil then
          uj.storage[item1] = 1
        else
          uj.storage[item1] = uj.storage[item1] + 1
        end
        
        ef[reaction.message.id] = nil
        reaction.message.channel:send("<@" .. uj.id .. "> successfully put their **" .. fntoname(item1) .. "** card in storage.")
        dpf.savejson("savedata/events.json",ef)
        dpf.savejson(ujf,uj)
      else
        local newmessage = reaction.message.channel:send("An error has occured. Please make sure that you still have the card in your inventory!")
      end
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      ef[reaction.message.id] = nil
      local newmessage = reaction.message.channel:send("<@" .. uj.id .. "> has successfully stopped the storage of their **" .. fntoname(item1) .. "** card.")
      dpf.savejson("savedata/events.json",ef)
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  
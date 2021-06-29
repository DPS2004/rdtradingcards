reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local newequip = eom.newequip
  local uj = dpf.loadjson(ujf, defaultjson)
  local time = sw:getTime()
  print("loaded uj")
  if uj.id == userid then
    print('user1 has reacted')
    
    if reaction.emojiName == "✅" then
      print('user1 has accepted')
      uj.equipped = newequip
      reaction.message.channel:send("<@" .. uj.id .. "> successfully set **" .. itemfntoname(newequip) .. "** as "..uj.pronouns["their"].." equipped item.")
      uj.lastequip = time:toHours()
      
      dpf.savejson(ujf, uj)
      ef[reaction.message.id] = nil
      
      dpf.savejson("savedata/events.json", ef)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      
      local newmessage = reaction.message.channel:send("<@" .. uj.id .. "> has successfully stopped the changing of "..uj.pronouns["their"].." equipped item.")
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json", ef)
      
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  

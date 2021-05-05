reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local newequip = eom.newequip
  local uj = dpf.loadjson(ujf, defaultjson)
  local time = sw:getTime()
  print("loaded uj")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)
  if uj.id == userid then
    print('user1 has reacted')
    
    if reaction.emojiName == "✅" then
      print('user1 has accepted')
     
  
      reaction.message.channel:send("The **Spider** smells like a small friend!")
      ef[reaction.message.id] = nil


      dpf.savejson("savedata/events.json",ef)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      reaction.message.channel:send("The Hand smells like nail polish.")


      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  
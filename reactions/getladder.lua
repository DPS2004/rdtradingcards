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
      
      uj.tokens = uj.tokens - 4
      local newmessage = reaction.message.channel:send {
        content = 'After depositing 4 **Tokens** and turning the crank, a capsule comes out of the **Strange Machine**. Inside it is the **Ladder!**! You put the **Ladder** in the hole. In addition, the **Strange Machine** seems to have calmed down.'
      }
      dpf.savejson(ujf,uj)
      ef[reaction.message.id] = nil
      wj.ws = 507 -- see setworldstate.lua
      dpf.savejson("savedata/worldsave.json", wj)
      
      dpf.savejson("savedata/events.json",ef)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      
      local newmessage = reaction.message.channel:send("You decide to not use the **Strange Machine**.")
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  
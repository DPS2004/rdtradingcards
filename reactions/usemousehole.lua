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
      
      uj.items.brokenmouse = nil
      uj.items.fixedmouse = true
      uj.equipped = "fixedmouse"
      local newmessage = reaction.message.channel:send {
        content = 'You start to push your **Broken Mouse** into the hole, but two grey furry hands pull it in the rest of the way. You can hear the mouse using a saw to open up the **Broken Mouse**, which seems terribly unsafe! After a few minutes of tinkering, the mouse pushes out a **Fixed Mouse**, complete with a green sticker denoting its newfound functionality. You put the **Fixed Mouse** with your other items.'
      }
      dpf.savejson(ujf,uj)
      ef[reaction.message.id] = nil
      
      dpf.savejson("savedata/events.json",ef)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      
      local newmessage = reaction.message.channel:send("You decide to not put the **Broken Mouse** in the **Mouse Hole**.")
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  
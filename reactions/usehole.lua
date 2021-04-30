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
     
      uj.tokens = uj.tokens - 1
      
      if uj.timesused == nil then
        uj.timesused = 1
      else
        uj.timesused = uj.timesused + 1
      end
      
      local newmessage = reaction.message.channel:send {
        content = 'A **Token** has been dropped into the **Hole.** Thank you for your generosity!'
      }
      dpf.savejson(ujf,uj)
      
      wj.tokensdonated = wj.tokensdonated + 1
      
      if wj.worldstate == "tinyhole" and wj.tokensdonated >= 5 then
        wj.worldstate = "smallhole"
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end
      if wj.worldstate == "smallhole" and wj.tokensdonated >= 10 then
        wj.worldstate = "mediumhole"
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end
      if wj.worldstate == "mediumhole" and wj.tokensdonated >= 15 then
        wj.worldstate = "largehole"
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end      
      if wj.worldstate == "largehole" and wj.tokensdonated >= 20 then
        wj.worldstate = "largerhole"
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles...***'
        }
      end
      if wj.worldstate == "largerhole" and wj.tokensdonated >= 30 then
        wj.worldstate = "largesthole"
        local newmessage = reaction.message.channel:send {
          content = '***The ground rumbles... and so does the Strange Machine***'
        }
      end
      
      ef[reaction.message.id] = nil
      
      dpf.savejson("savedata/events.json",ef)
      dpf.savejson("savedata/worldsave.json", wj)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      
      local newmessage = reaction.message.channel:send("You decide to not put a **Token** into the **Hole.** (how rude!)")
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  
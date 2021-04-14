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
     
  
      reaction.message.channel:send{embed = {
        color = 0x85c5ff,
        title = "Using Spider...",
        description = "The **Spider** waves at you. You wave back. A true bond between the two of you has been formed!",
        image = {
          url = 'https://cdn.discordapp.com/attachments/829197797789532181/831930184482422824/spiderwave.png'
        }
      }}
      ef[reaction.message.id] = nil
      if uj.timesused == nil then
        uj.timesused = 1
      else
        uj.timesused = uj.timesused + 1
      end

      dpf.savejson("savedata/events.json",ef)
      dpf.savejson("savedata/worldsave.json", wj)
    end
    if reaction.emojiName == "❌" then
      print('user1 has denied')
      reaction.message.channel:send{embed = {
        color = 0x85c5ff,
        title = "Using Spiderweb...",
        description = "There is a **Spiderweb** here, but there is no **Spider**. There never **was** and there never **will** be a **Spider** in this location.",
        image = {
          url = 'https://cdn.discordapp.com/attachments/829197797789532181/831930243249864704/hand.png'
        }
      }}

      if uj.timesused == nil then
        uj.timesused = 1
      else
        uj.timesused = uj.timesused + 1
      end
      ef[reaction.message.id] = nil
      dpf.savejson("savedata/events.json",ef)
      dpf.savejson("savedata/worldsave.json", wj)
      
    end
  else
    print("its not uj1 reacting")
  end
end
return reaction
  
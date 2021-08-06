local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  if uj.id ~= userid then
    print("It's not uj1 reacting")
    return
  end

  print('user1 has reacted')
  uj.timesused = uj.timesused and uj.timesused + 1 or 1
  dpf.savejson(ujf, uj)
  
  ef[reaction.message.id] = nil
  dpf.savejson("savedata/events.json", ef)
  
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
  end
end
return reaction
  
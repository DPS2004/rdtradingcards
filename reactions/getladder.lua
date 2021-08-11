local reaction = {}
function reaction.run(ef, eom, reaction, userid)
  local ujf = eom.ujf
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)

  if uj.id ~= userid then
    print("its not uj1 reacting")
    return
  end

  print('user1 has reacted')
  client:emit(reaction.message.id)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    if uj.tokens < 4 then
      reaction.message.channel:send("An error has occured. Please make sure that you still have enough tokens!")
      return
    end
    uj.tokens = uj.tokens - 4
    wj.ws = 507 -- see setworldstate.lua
    reaction.message.channel:send('After depositing 4 **Tokens** and turning the crank, a capsule comes out of the **Strange Machine**. Inside it is the **Ladder!**! You put the **Ladder** in the hole. In addition, the **Strange Machine** seems to have calmed down.')
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/worldsave.json", wj)
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("You decide to not use the **Strange Machine**.")
  end
end
return reaction

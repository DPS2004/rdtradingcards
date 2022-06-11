local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)

  if response == "yes" then
    print('user1 has accepted')

    if uj.tokens < 4 then
      interaction:reply("An error has occured. Please make sure that you still have enough tokens!")
      return
    end

    uj.tokens = uj.tokens - 4
    wj.ws = 507 -- see setworldstate.lua
    interaction:reply('After depositing 4 **Tokens** and turning the crank, a capsule comes out of the **Strange Machine**. Inside it is the **Ladder!**! You put the **Ladder** in the hole. In addition, the **Strange Machine** seems to have calmed down.')
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/worldsave.json", wj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply("You decide to not use the **Strange Machine**.")
  end
end
return reaction

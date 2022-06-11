local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)

  if response == "yes" then
    print('user1 has accepted')
    if uj.tokens < 1 then
      interaction:reply("An error has occured. Please make sure that you still have a token!")
      return
    end

    uj.tokens = uj.tokens - 1
    uj.timesused = uj.timesused and uj.timesused + 1 or 1
    uj.tokensdonated = uj.tokensdonated and uj.tokensdonated + 1 or 1

    if not wj.labdiscovered then
      interaction:reply('A **Token** has been dropped into the **Hole.** Thank you for your generosity!')
    else
      interaction:reply{embed = {
        color = 0x85c5ff,
        title = "Using Terminal...",
        description = 'The **Terminal** whirrs happily. A printout lets you know that ' .. wj.tokensdonated .. ' tokens have been donated so far.',
        image = {
          url = upgradeimages[math.random(#upgradeimages)]
        },
        footer = {
          text =  message.author.name,
          icon_url = message.author.avatarURL
        }
      }}
    end

    wj.tokensdonated = wj.tokensdonated + 1

    if wj.ws >= 501 and wj.ws < 506 and wj.tokensdonated >= (wj.ws - 500) * 5 then
      wj.ws = wj.ws + 1
      interaction:reply("***The ground rumbles..." .. (wj.ws == 506 and " and so does the Strange Machine***" or "***"))
    end

    if not wj.smellable and wj.tokensdonated >= 100 then
      wj.smellable = true
      interaction:reply('***The Database lets out a loud BEEP, before the Hole above you closes off. The Terminal begins spewing a noxious gas. ***\n.\n..\n...\n***When you wake up, the Hole has opened again, and your sense of Smell feels much more potent.***')
    end

    dpf.savejson(ujf, uj)
    dpf.savejson("savedata/worldsave.json", wj)
  end

  if response == "no" then
    print('user1 has denied')
    if not wj.labdiscovered then
      interaction:reply("You decide to not put a **Token** into the **Hole.** (how rude!)")
    else
      interaction:reply("You decide to not put a **Token** into the **Terminal.** (how rude!)")
    end
  end
end
return reaction

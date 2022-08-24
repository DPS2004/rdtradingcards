local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/usehole.json", "")
  print("Loaded uj")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)

  if response == "yes" then
    print('user1 has accepted')
    if uj.tokens < 1 then
      interaction:reply(lang.error_no_tokens)
      return
    end

    uj.tokens = uj.tokens - 1
    uj.timesused = uj.timesused and uj.timesused + 1 or 1
    uj.tokensdonated = uj.tokensdonated and uj.tokensdonated + 1 or 1

    if not wj.labdiscovered then
      interaction:reply(lang.donated_hole)
    else
      interaction:reply{embed = {
        color = 0x85c5ff,
        title = lang.using_terminal,
        description = lang.donated_terminal_1 .. wj.tokensdonated .. lang.donated_terminal_2,
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
      interaction:reply(lang.donated_hole_ws_1 .. (wj.ws == 506 and lang.donated_hole_ws_506 or lang.donated_hole_ws_2))
    end

    if not wj.smellable and wj.tokensdonated >= 100 then
      wj.smellable = true
      interaction:reply(lang.donated_terminal_smell)
    end

    dpf.savejson(ujf, uj)
    dpf.savejson("savedata/worldsave.json", wj)
  end

  if response == "no" then
    print('user1 has denied')
    if not wj.labdiscovered then
      interaction:reply(lang.denied_hole)
    else
      interaction:reply(lang.denied_terminal)
    end
  end
end
return reaction

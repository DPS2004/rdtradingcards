local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/pyrowmid/machine.json")
  print("Loaded uj")
  local wj = dpf.loadjson("savedata/worldsave.json", defaultworldsave)

  if response == "yes" then
    print('user1 has accepted')

    if uj.tokens < 4 then
      interaction:reply(lang.error_no_tokens)
      return
    end

    uj.tokens = uj.tokens - 4
    wj.ws = 507 -- see setworldstate.lua
    interaction:reply(lang.used_machine_ladder)
    dpf.savejson(ujf,uj)
    dpf.savejson("savedata/worldsave.json", wj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.denied_message)
  end
end
return reaction

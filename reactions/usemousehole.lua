local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/use/lab/lab.json")
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')
    uj.items.brokenmouse = nil
    uj.items.fixedmouse = true
    uj.equipped = "fixedmouse"

    interaction:reply(lang.used_hole)
    dpf.savejson(ujf,uj)
  end
  
  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.denied_hole)
  end
end
return reaction

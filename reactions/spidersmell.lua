local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  local lang = dpf.loadjson("langs/" .. uj.lang .. "/smell.json")
  print("Loaded uj")
  

  if response == "yes" then
    print('user1 has accepted')
    interaction:reply(lang.smell_spider)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply(lang.smell_hand)
  end
end
return reaction

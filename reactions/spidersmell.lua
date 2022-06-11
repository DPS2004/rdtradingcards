local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")
  

  if response == "yes" then
    print('user1 has accepted')
    interaction:reply("The **Spider** smells like a small friend!")
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply("The **Hand** smells like nail polish.")
  end
end
return reaction

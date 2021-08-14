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
  client:emit(reaction.message.id)

  if reaction.emojiName == "✅" then
    print('user1 has accepted')
    reaction.message.channel:send("The **Spider** smells like a small friend!")
  end

  if reaction.emojiName == "❌" then
    print('user1 has denied')
    reaction.message.channel:send("The **Hand** smells like nail polish.")
  end
end
return reaction
